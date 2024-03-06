//
//  StoriesContentView.swift
//  arlnc-iOS
//
//  Created by resoul on 06.03.2024.
//

import UIKit

class StoriesContentView: UIView {
    
    private lazy var content: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(content)
        content.constraints(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesContentView {
    func configure(with viewModel: StoriesViewModel?) {
        guard let viewModel = viewModel, let url = URL(string: viewModel.stories[viewModel.lastViewedIndex].imagePath) else {
            return
        }
        
        ImageCacheManager.shared.cache(with: url) { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.content.image = image
            }
        }
    }
}
