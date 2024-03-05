//
//  StoriesMeView.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

import UIKit

class StoriesMeView: UICollectionViewCell {
    
    private let addStoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let profileImageView: StoriesRoundedView = {
        let roundedView = StoriesRoundedView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        return roundedView
    }()
    
    lazy var addImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "add-btn")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 20/2
        iv.layer.borderWidth = 2.0
        iv.layer.borderColor = UIColor.systemBackground.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(addStoryLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(addImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 68),
            profileImageView.heightAnchor.constraint(equalToConstant: 68),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addStoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addStoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addStoryLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 2),
            addStoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addStoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            addImageView.widthAnchor.constraint(equalToConstant: 20),
            addImageView.heightAnchor.constraint(equalToConstant: 20),
            addImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesMeView {
    func configure(with viewModel: StoriesViewModel) {
        addStoryLabel.text = viewModel.user.username
        profileImageView.imageView.layer.borderColor = UIColor.systemBackground.cgColor
        profileImageView.layer.borderColor = UIColor.systemBackground.cgColor
        
        let url = URL(string: viewModel.user.profilePicture)
        ImageCacheManager.shared.cache(with: url!) { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.profileImageView.imageView.image = image
            }
        }
    }
}
