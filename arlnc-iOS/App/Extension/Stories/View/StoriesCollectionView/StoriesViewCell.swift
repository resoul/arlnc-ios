//
//  StoriesViewCell.swift
//  arlnc-iOS
//

import UIKit

class StoriesViewCell: UICollectionViewCell {
    
    lazy var addButtonView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "add-btn")
        iv.layer.cornerRadius = 26/2
        iv.layer.borderWidth = 3.0
        iv.layer.borderColor = UIColor.systemBackground.cgColor
        iv.clipsToBounds = true
        return iv
    }()

    lazy var avatarView = StoriesViewAvatarCell()
    
    let profileName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(avatarView, profileName, addButtonView)
        avatarView.constraints(top: contentView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 88, height: 88))
        avatarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileName.constraints(top: avatarView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        addButtonView.constraints(top: nil, leading: nil, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 23, right: 8), size: .init(width: 26, height: 26))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoriesViewCell {
    func configure (with account: AccountViewModel) {
        profileName.text = account.username
        if me.uuid != account.uuid {
            addButtonView.isHidden = true
        }
        
        let url = URL(string: account.profilePicture)
        ImageCacheManager.shared.cache(with: url!) { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                if me.uuid == account.uuid {
                    self?.avatarView.setupAvatar(image: image, origin: 88, scale: 0)
                } else {
                    self?.avatarView.setupAvatar(image: image, origin: 82, scale: 3)
                }
            }
        }
    }
}
