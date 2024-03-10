//
//  StoriesPresenterController.swift
//  arlnc-iOS
//

import UIKit

class StoriesPresenterController: UIViewController {
    
    private(set) var viewModel: StoriesViewModel
    
    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
