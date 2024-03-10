//
//  StoriesTransitionContext.swift
//  arlnc-iOS
//

import UIKit

class StoriesTransitionContext: NSObject, UIViewControllerContextTransitioning {
    var containerView: UIView
    
    var isAnimated: Bool
    
    var isInteractive: Bool
    
    var transitionWasCancelled: Bool
    
    var presentationStyle: UIModalPresentationStyle
    
    var viewControllers: [UITransitionContextViewControllerKey : UIViewController]
    var views: [UITransitionContextViewKey : UIView]
    var travelDistance: CGFloat
    var disappearingFromRect: CGRect
    var disappearingToRect: CGRect
    var appearingToRect: CGRect
    var appearingFromRect: CGRect
    
    init(fromVC: UIViewController, toVC: UIViewController, goingRight: Bool) {
        
        self.presentationStyle = .custom
        self.containerView = fromVC.view.superview!
        self.viewControllers = [.from : fromVC, .to : toVC]
        self.views = [.from : fromVC.view, .to : toVC.view]
        self.travelDistance = (goingRight) ? -self.containerView.bounds.size.width : self.containerView.bounds.size.width
        
        self.disappearingFromRect = self.containerView.bounds
        self.appearingToRect = self.containerView.bounds
        self.disappearingToRect = self.containerView.bounds.offsetBy(dx: travelDistance, dy: 0)
        self.appearingFromRect = self.containerView.bounds.offsetBy(dx: -travelDistance, dy: 0)
        
        isAnimated = true
        isInteractive = true
        transitionWasCancelled = false
        targetTransform = .identity
        
        super.init()
    }
    
    func updateInteractiveTransition(_ percentComplete: CGFloat) {
        isInteractive = true
        isAnimated = false
    }
    
    func finishInteractiveTransition() {
        isInteractive = false
    }
    
    func cancelInteractiveTransition() {
        isInteractive = false
        transitionWasCancelled = true
    }
    
    func pauseInteractiveTransition() {
        isInteractive = false
    }
    
    var completionBlock: ((Bool) -> Void)?
    func completeTransition(_ didComplete: Bool) {
        completionBlock?(didComplete)
    }
    
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        return viewControllers[key]
    }
    
    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return views[key]
    }
    
    var targetTransform: CGAffineTransform
    
    func initialFrame(for vc: UIViewController) -> CGRect {
 
        if vc == viewController(forKey: .from) {
            return self.disappearingToRect
        } else {
            return self.appearingToRect
        }
    }
    
    func finalFrame(for vc: UIViewController) -> CGRect {
        
        if vc == viewController(forKey: .from) {
            return self.disappearingFromRect
        } else {
            return self.appearingFromRect
        }
    }
}
