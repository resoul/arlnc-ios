//
//  StoriesProgressView.swift
//  arlnc-iOS
//
//  Created by resoul on 06.03.2024.
//

import UIKit

class StoriesProgressView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
