//
//  StoriesController.swift
//  arlnc-iOS
//

import UIKit

class StoriesController: UIViewController {
    
    weak var delegate: StoriesControllerDelegate?
    
    private(set) var viewModel: StoriesViewModel
    
    private lazy var storieContent: StorieContent = {
        let view = StorieContent()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        
        return view
    }()
    
    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bottom = UIView()
        
        view.addSubviews(storieContent, bottom)
        storieContent.constraints(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        bottom.constraints(top: storieContent.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 110))

        storieContent.configure(viewModel: viewModel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(storieFinishedEvent(_:)), name: NSNotification.Name("storie.process.finished"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    @objc
    func storieFinishedEvent(_ notification: Notification) {
        print(viewModel.showStorieIndex)
        if let index = notification.userInfo?["index"] as? Int {
            let current = index + 1
            if viewModel.stories.count > current {
                viewModel.showStorieIndex = current
                storieContent.changeStorie(viewModel: viewModel)
            } else if viewModel.stories.count == current {
                print("viewModel.showStorieIndex")
                viewModel.showStorieIndex = 0
                delegate?.routeToNext()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol StoriesControllerDelegate: AnyObject {
    func routeToNext()
}
