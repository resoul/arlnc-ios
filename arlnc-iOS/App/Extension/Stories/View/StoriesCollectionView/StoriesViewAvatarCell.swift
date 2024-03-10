//
//  StoriesViewAvatarCell.swift
//  arlnc-iOS
//

import UIKit

class StoriesViewAvatarCell: UIView {
    
    private lazy var avatar: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.borderWidth = 3.0
        view.layer.borderColor = UIColor.systemBackground.cgColor
        
        return view
    }()
    
    func setupAvatar(image: UIImage, origin: CGFloat, scale: CGFloat) {
        avatar.image = image
        avatar.frame = CGRect(x: scale, y: scale, width: origin, height: origin)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(avatar)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer = layer as? CAGradientLayer {
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        
        layer.cornerRadius = frame.height / 2
        avatar.layer.cornerRadius = avatar.frame.height / 2
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
