//
//  StoryController.swift
//  arlnc-iOS
//
//  Created by resoul on 07.03.2024.
//

import UIKit

class StoryController: UIViewController, UIGestureRecognizerDelegate {
    
    private(set) var viewModel: StoriesViewModel
    
    init(stories: StoriesViewModel) {
        viewModel = stories
        super.init(nibName: nil, bundle: nil)
    }
    
    private lazy var touchGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(handleContentDirection(_:)))
        
        return gesture
    }()
    
    private lazy var contentView: StoriesContentView = {
        let view = StoriesContentView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var bottomView: StoriesBottomView = {
        let view = StoriesBottomView()

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(contentView, bottomView)
        touchGesture.delegate = self
        contentView.addGestureRecognizer(touchGesture)
        
        contentView.constraints(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        bottomView.constraints(top: contentView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 80))
    }
    
    @objc
    func handleContentDirection(_ sender: UITapGestureRecognizer) {
        let direction = (contentView.frame.size.width - 10) / 2
        print("handleContentDirection", sender.location(in: contentView).x > direction)
        if sender.location(in: contentView).x > direction {
            if viewModel.stories.count > (viewModel.lastViewedIndex + 1) {
                viewModel.lastViewedIndex += 1
            } else {
                // next story
            }
        } else {
            if viewModel.lastViewedIndex > 0 {
                viewModel.lastViewedIndex -= 1
            } else {
                // prev story
            }
        }
        
        contentView.configure(with: viewModel)
        bottomView.configure(with: viewModel)
    }
    
    @objc
    func handleDismissGesture() {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.configure(with: viewModel)
        bottomView.configure(with: viewModel)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
