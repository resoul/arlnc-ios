//
//  StoriesBottomView.swift
//  arlnc-iOS
//
//  Created by resoul on 06.03.2024.
//

import UIKit

class StoriesBottomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesBottomView {
    func configure(with viewModel: StoriesViewModel?) {}
}
