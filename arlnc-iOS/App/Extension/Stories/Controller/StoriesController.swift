//
//  StoriesController.swift
//  arlnc-iOS
//
//  Created by resoul on 07.03.2024.
//

import UIKit

class StoriesController: UIViewController, UIGestureRecognizerDelegate {
    
    private(set) var stories: [Stories]
    
    private(set) var indexPath: IndexPath
    
    private var currentIndex: Int = 0
    
    private var childControllers: [StoryController] = []
    
    private lazy var dismissGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .down
        gesture.addTarget(self, action: #selector(handleDismissGesture))
        
        return gesture
    }()
    
    init(stories: [Stories], indexPath: IndexPath) {
        self.stories = stories
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addGestureRecognizer(dismissGesture)
        dismissGesture.delegate = self
        
        for story in stories {
            let model = StoriesViewModel(user: story.user, isMe: story.isMe, isLive: story.isLive, lastViewedIndex: story.lastViewedIndex, stories: story.stories)
            let controller = StoryController(stories: model)
            
            childControllers.append(controller)
        }
        currentIndex = indexPath.row
        addChildController(childControllers[currentIndex])
        setupSwipeGesture()
    }
    
    @objc
    func handleDismissGesture() {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addChildController(_ childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }

    private func removeChildController(_ childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }

    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        print("swipe", gesture.direction)
        switch gesture.direction {
        case .left:
            if currentIndex < childControllers.count - 1 {
                removeChildController(childControllers[currentIndex])
                currentIndex += 1
                addChildController(childControllers[currentIndex])
            }
        case .right:
            if currentIndex > 0 {
                removeChildController(childControllers[currentIndex])
                currentIndex -= 1
                addChildController(childControllers[currentIndex])
            }
        default:
            break
        }
    }

    func setupSwipeGesture() {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeftGesture.direction = .left
        swipeLeftGesture.delegate = self
        view.addGestureRecognizer(swipeLeftGesture)

        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRightGesture.direction = .right
        swipeRightGesture.delegate = self
        view.addGestureRecognizer(swipeRightGesture)
    }
}
