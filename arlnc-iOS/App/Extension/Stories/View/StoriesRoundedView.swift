//
//  StoriesRoundedView.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

import UIKit

class StoriesRoundedView: UIView {

    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderWidth = 2.0
        iv.clipsToBounds = true
        return iv
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.frame = CGRect(x: 1, y: 1, width: 66, height: 66)
    }
}
