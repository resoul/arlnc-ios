//
//  StoriesAvatarView.swift
//  arlnc-iOS
//
//  Created by resoul on 06.03.2024.
//

import UIKit

class StoriesAvatarView: UIView {
    
    private lazy var avatarContainer: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor.systemBackground.cgColor
        
        return view
    }()
    
    func setAvatar(image: UIImage, origin: CGFloat, scale: CGFloat) {
        avatarContainer.image = image
        avatarContainer.frame = CGRect(x: scale, y: scale, width: origin, height: origin)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(avatarContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer = layer as? CAGradientLayer {
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        
        layer.cornerRadius = frame.height / 2
        avatarContainer.layer.cornerRadius = avatarContainer.frame.height / 2
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
