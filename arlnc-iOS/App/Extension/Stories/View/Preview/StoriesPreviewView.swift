//
//  StoriesPreviewView.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

import UIKit

class StoriesPreviewView: UICollectionViewCell, UIScrollViewDelegate {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.frame = bounds
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        contentView.addSubview(scrollView)
        
        let snapView = UIImageView()
        snapView.translatesAutoresizingMaskIntoConstraints = false
        snapView.image = UIImage(named: "test")
        //snapView.kf.setImage(with: URL(string: ""))
 
        snapView.contentMode = .scaleAspectFill
        scrollView.addSubview(snapView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),
            scrollView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0),
            snapView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            snapView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            snapView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            snapView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
