//
//  StoriesPresenterController.swift
//  arlnc-iOS
//

import UIKit

class StoriesPresenterController: UIViewController {
    
    private(set) var viewModel: StoriesPresenterViewModel
    private(set) var viewControllers: Array<UIViewController> = []
    private(set) var selectedViewController: UIViewController?
    private(set) var transition: StoriesTransition?
    
    private lazy var transitionGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer()
        gesture.addTarget(self, action: #selector(handlePanGesture(_:)))
        
        return gesture
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(handleLongPressGesture(_:)))
        gesture.minimumPressDuration = 0.2
        
        return gesture
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(handleTapGesture(_:)))
        
        return gesture
    }()
    
    init(viewModel: StoriesPresenterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupStories()
        selectedViewController = viewControllers[viewModel.currentIndex]
        guard let controller = selectedViewController else {
            ///TODO - error popup
            return
        }
        addChildController(controller)
        view.addGestureRecognizer(transitionGesture)
        view.addGestureRecognizer(longPressGesture)
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        print("handleTapGesture", gesture)
    }
    
    @objc
    func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("handleLongPressGesture", "pause")
        } else if gesture.state == .ended {
            print("handleLongPressGesture", "resume")
        }
    }
    
    @objc
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended && gesture.velocity(in: view).y > 80 {
            //dismiss(animated: true)
        }
        guard children.count == 1 else { return }
        let isInteractive: Bool
        if let transition = transition {
            isInteractive = transition.transitionContext.isInteractive
        } else {
            isInteractive = false
        }
        
        if !isInteractive {
            let currentVCIndex = self.viewControllers.firstIndex(of: self.selectedViewController!)!
            let leftToRight: Bool = gesture.velocity(in: gesture.view).x > 0
            var nextIDX: Int?
            if !leftToRight && currentVCIndex != self.viewControllers.count-1 {
                nextIDX = currentVCIndex + 1
            } else if leftToRight && currentVCIndex > 0 {
                nextIDX = currentVCIndex - 1
            }
            if let nextIDX = nextIDX {
                selectCandTransition(viewControllers[nextIDX])
            }
        }
    }
    
    fileprivate func setupStories() {
        for storie in viewModel.stories {
            let model = StoriesViewModel(user: storie.user, showStorieIndex: storie.currentStoriesIndex, stories: storie.stories)
            let controller = StoriesController(viewModel: model)
            controller.delegate = self
            viewControllers.append(controller)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesPresenterController: StoriesControllerDelegate {
    func routeToNext() {
        let currentVCIndex = self.viewControllers.firstIndex(of: self.selectedViewController!)!
        let nextIDX = currentVCIndex + 1
        viewModel.currentIndex = nextIDX
        selectedViewController = viewControllers[nextIDX]
        
        removeChildController(viewControllers[currentVCIndex])
        addChildController(viewControllers[nextIDX])
    }
}

extension StoriesPresenterController: StoriesTransitionDelegate, UIViewControllerTransitioningDelegate {
    func animationControllerForTransition(from: UIViewController, to: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = StoriesTransition(panGesture: transitionGesture)
        return transition
    }
    
    func selectCandTransition(_ selected: UIViewController) {
        selectedViewController = selected
        transitionToChild(to: selected)
    }
    
    private func transitionToChild(to: UIViewController) -> Void {
        guard self.children.count > 0 else { return }
        let fromViewController = self.children[0]
        if to === fromViewController { return }
        guard
            let fromIndex = self.viewControllers.firstIndex(of: fromViewController),
            let toIndex = self.viewControllers.firstIndex(of: to) else {
            return
        }
        
        if let transition = animationControllerForTransition(from: fromViewController, to: to) {
            let context = StoriesTransitionContext(fromVC: fromViewController, toVC: to, goingRight: toIndex < fromIndex)
            print("index", fromIndex, toIndex)
            
            print("context", context)
            fromViewController.willMove(toParent: nil)
            addChildController(to)
          
            context.completionBlock = { [ weak self ] (didComplete: Bool) -> Void in
                guard let self = self else { return }
                print("didComplete", didComplete)
                if didComplete {
                    removeChildController(fromViewController)
                } else {
                    removeChildController(to)
                    self.selectedViewController = fromViewController
                    print("not didComplete", didComplete)
                }
                
                transition.animationEnded?(didComplete)
            }

            context.isAnimated = true
            context.isInteractive = true
            transition.animateTransition(using: context)
        }
    }
}
