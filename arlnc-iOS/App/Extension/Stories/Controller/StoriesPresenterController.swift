//
//  StoriesPresenterController.swift
//  arlnc-iOS
//

import UIKit

class StoriesPresenterController: UIViewController {
    
    private(set) var viewModel: StoriesPresenterViewModel
    private(set) var viewControllers: Array<UIViewController> = []
    private(set) var selectedViewController: UIViewController?
    
    private lazy var transitionGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer()
        gesture.addTarget(self, action: #selector(handleGesture(_:)))
        
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
    }
    
    @objc
    func handleGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended && gesture.velocity(in: view).y > 50 {
            dismiss(animated: true)
        }
    }
    
    fileprivate func setupStories() {
        for storie in viewModel.stories {
            let model = StoriesViewModel(user: storie.user, showStorieIndex: storie.currentStoriesIndex, stories: storie.stories)
            viewControllers.append(StoriesController(viewModel: model))
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
