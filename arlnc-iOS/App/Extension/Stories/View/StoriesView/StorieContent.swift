//
//  StorieContent.swift
//  arlnc-iOS
//

import UIKit

class StorieContent: UIView {
    
    private lazy var storie: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private lazy var storieHeader: StorieHeader = {
        let view = StorieHeader()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(storie)
        storie.constraints(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        storie.addSubview(storieHeader)
        storieHeader.constraints(top: storie.topAnchor, leading: storie.leadingAnchor, bottom: nil, trailing: storie.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 45))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StorieContent {
    func configure(viewModel: StoriesViewModel) {
        storie.cacheImage(string: viewModel.stories[viewModel.showStorieIndex].path)
        storieHeader.configure(viewModel: viewModel)
    }
    
    func changeStorie(viewModel: StoriesViewModel) {
        //print(viewModel)
        //storie.cacheImage(string: viewModel.stories[viewModel.showStorieIndex].path)
        //storieHeader.rebuild(viewModel: viewModel)
    }
}
