//
//  StorieHeader.swift
//  arlnc-iOS
//

import UIKit

class StorieHeader: UIView {
    
    private lazy var profileView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        
        return label
    }()
    
    private let date: UILabel = {
        let label = UILabel()
        label.textColor = .label
        
        return label
    }()
    
    private lazy var moreBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tintColor = .white
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.addTarget(self, action: #selector(handleMoreBtn), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tintColor = .white
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.addTarget(self, action: #selector(handleCloseBtn), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var progressView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.distribution = .fillEqually
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(progressView, profileView, username, date, closeBtn, moreBtn)
        progressView.constraints(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 3))
        
        profileView.constraints(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 30, height: 30))
        username.constraints(top: nil, leading: profileView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 8, bottom: 0, right: 0))
        date.constraints(top: nil, leading: username.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 8, bottom: 0, right: 0))
        
        closeBtn.constraints(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 20, height: 20))
        moreBtn.constraints(top: nil, leading: nil, bottom: nil, trailing: closeBtn.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 15), size: .init(width: 20, height: 20))
        
        profileView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        username.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        date.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        closeBtn.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        moreBtn.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
    }
    
    @objc
    func handleMoreBtn() {}
    
    @objc
    func handleCloseBtn() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StorieHeader {
    func configure(viewModel: StoriesViewModel) {
        profileView.cacheImage(string: viewModel.user.profilePicture)
        username.text = viewModel.user.username
        date.text = viewModel.stories[viewModel.showStorieIndex].date
        
        for (i, _) in viewModel.stories.enumerated() {
            let view = StorieProgress(index: i)
            if viewModel.showStorieIndex > i {
                view.progress = 1.0
            }
            progressView.insertArrangedSubview(view, at: i)
        }
        if let view = progressView.arrangedSubviews[viewModel.showStorieIndex] as? StorieProgress {
            view.startProgress()
        }
    }
    
    func rebuild(viewModel: StoriesViewModel) {
        for (i, view) in progressView.arrangedSubviews.enumerated() {
            if let v = view as? StorieProgress {
                v.resetProgress()
                if viewModel.showStorieIndex > i {
                    v.setProgress(1.0, animated: false)
                    v.layoutIfNeeded()
                } else if viewModel.showStorieIndex == i {
                    v.startProgress()
                }
            }
        }
    }
}
