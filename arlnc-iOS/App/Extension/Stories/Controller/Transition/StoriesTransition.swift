//
//  StoriesTransition.swift
//  arlnc-iOS
//

import UIKit

class StoriesTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning {
    var transitionContext: UIViewControllerContextTransitioning!
    
    private var latestVelocity: CGPoint = .zero
    private var goingRight: Bool = false
    private let velocitySwipeThreshold: CGFloat = 1000.0
    private var propertyAnimator: UIViewPropertyAnimator?
    private var panGestureRecongnizer: UIPanGestureRecognizer!
    private var progressAtTouchBegin: CGFloat = 0.0
    private let kCChildViewPadding: CGFloat = 16
    
    init(panGesture: UIPanGestureRecognizer) {
        self.panGestureRecongnizer = panGesture
        super.init()
    }
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let animator = interruptibleAnimator(using: transitionContext)
        if transitionContext.isInteractive {
            animator.pauseAnimation()
        } else {
            animator.startAnimation()
            transitionContext.pauseInteractiveTransition()
        }
        transitionContext.containerView.addGestureRecognizer(self.panGestureRecongnizer)
        self.panGestureRecongnizer.addTarget(self, action: #selector(handleGesture(_:)))
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) else {
            fatalError()
        }
        let goingRight: Bool = transitionContext.initialFrame(for: toViewController).origin.x < transitionContext.finalFrame(for: toViewController).origin.x
        self.goingRight = goingRight
        
        let travelDistance = transitionContext.containerView.bounds.size.width + self.kCChildViewPadding
        let travel: CGAffineTransform = CGAffineTransform.init(translationX: goingRight ? travelDistance : -travelDistance, y: 0)
        
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.transform = travel.inverted()
        
        let duration = transitionDuration(using: transitionContext)
        
        let mass: CGFloat = 0.07
        let stiffness: CGFloat = 12.0
        let damping: CGFloat = 1.10
        let initialVelocity = CGVector(dx: 1, dy: 0)
        let timingSpring = UISpringTimingParameters(mass: mass,
                                                    stiffness: stiffness,
                                                    damping: damping,
                                                    initialVelocity: initialVelocity)
        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: timingSpring)
        animator.isUserInteractionEnabled = true
        animator.isInterruptible = true
        animator.scrubsLinearly = true
        animator.addAnimations {
            fromViewController.view.transform = travel
            toViewController.view.transform = .identity
        }
        animator.addCompletion { (position) in
            let didComplete = (position == .end)
            transitionContext.completeTransition(didComplete)
        }
        
        self.propertyAnimator = animator
        return animator
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        if transitionCompleted {
            self.panGestureRecongnizer.removeTarget(self, action: #selector(handleGesture(_:)))
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.startInteractiveTransition(transitionContext)
    }

    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard
            let animator = self.propertyAnimator,
            let fromVCView = transitionContext.view(forKey: .from) else { return }
        
        switch gestureRecognizer.state
        {
        case .began:
            animator.pauseAnimation()
            animator.isReversed = false
            self.progressAtTouchBegin = animator.fractionComplete

        case .changed:
            let velocity = gestureRecognizer.velocity(in: fromVCView)
            latestVelocity = velocity
            
            let translation = gestureRecognizer.translation(in: fromVCView)
            let dx: CGFloat = translation.x/transitionContext.containerView.bounds.width
            let progressUpdate: CGFloat = progressAtTouchBegin + (goingRight ? dx : -dx)

            animator.fractionComplete = progressUpdate
            self.transitionContext.updateInteractiveTransition(progressUpdate)
        case .ended, .cancelled:
 
            transitionContext.pauseInteractiveTransition()
            if animator.fractionComplete > 0.5 || abs(latestVelocity.x) > velocitySwipeThreshold {
                if goingRight {
                    if latestVelocity.x < 0 {
                        animator.isReversed = true
                        animator.startAnimation()
                        break
                    }
                    
                } else if !goingRight {
                    if latestVelocity.x > 0 {
                        animator.isReversed = true
                        animator.startAnimation()
                        break
                    }
                }
                animator.startAnimation()
     
            } else {
                animator.isReversed = true
                animator.startAnimation()
            }
            transitionContext.finishInteractiveTransition()
            break
        default:
            break
        }
    }
}
