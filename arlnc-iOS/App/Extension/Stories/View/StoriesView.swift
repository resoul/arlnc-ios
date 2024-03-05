//
//  StoriesView.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

import UIKit

class StoriesView: UICollectionViewCell {

    private let profileImageView: StoriesRoundedView = {
        let roundedView = StoriesRoundedView()
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        return roundedView
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 68),
            profileImageView.heightAnchor.constraint(equalToConstant: 68),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            profileNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            profileNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 2),
            profileNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesView {
    func configure(with viewModel: StoriesViewModel) {
        profileNameLabel.text = viewModel.user.username
        profileImageView.backgroundColor = .cyan
        profileImageView.imageView.layer.borderWidth = 2.0
        profileImageView.imageView.layer.borderColor = UIColor.systemBackground.cgColor
        profileImageView.layer.borderWidth = 2.0
        profileImageView.layer.borderColor = UIColor.cyan.cgColor
        
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
