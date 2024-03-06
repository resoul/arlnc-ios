//
//  StoriesView.swift
//  arlnc-iOS
//
//  Created by resoul on 06.03.2024.
//

import UIKit

class StoriesView: UICollectionViewCell {
    
    lazy var addImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "add-btn")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 26/2
        iv.layer.borderWidth = 3.0
        iv.layer.borderColor = UIColor.systemBackground.cgColor
        iv.clipsToBounds = true
        return iv
    }()

    private lazy var avatarView = StoriesAvatarView()
    
    private lazy var liveText: UILabel = {
        let label = UILabel()
        label.text = "LIVE"
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 4

        return label
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBackground
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(profileNameLabel)
        contentView.addSubviews(avatarView, liveText)
        contentView.addSubview(addImageView)
        
        liveText.translatesAutoresizingMaskIntoConstraints = false
        
        avatarView.constraints(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 88, height: 88))
        avatarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        NSLayoutConstraint.activate([
            profileNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            profileNameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 2),
            profileNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addImageView.widthAnchor.constraint(equalToConstant: 26),
            addImageView.heightAnchor.constraint(equalToConstant: 26),
            addImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23)
        ])
        
        NSLayoutConstraint.activate([
            liveText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            liveText.widthAnchor.constraint(equalToConstant: 55),
            liveText.heightAnchor.constraint(equalToConstant: 26),
            liveText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesView {
    func configure(with viewModel: StoriesViewModel) {
        liveText.isHidden = !viewModel.isLive
        addImageView.isHidden = !viewModel.isMe
        profileNameLabel.text = viewModel.user.username
        let url = URL(string: viewModel.user.profilePicture)
        ImageCacheManager.shared.cache(with: url!) { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                if viewModel.isMe {
                    self?.avatarView.setAvatar(image: image, origin: 88, scale: 0)
                } else {
                    self?.avatarView.setAvatar(image: image, origin: 82, scale: 3)
                }
            }
        }
    }
}
