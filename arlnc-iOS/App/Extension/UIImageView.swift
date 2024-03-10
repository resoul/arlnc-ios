//
//  UIImageView.swift
//  arlnc-iOS
//

import UIKit

extension UIImageView {
    
    func cacheImage(string: String) {
        if let url = URL(string: string) {
            ImageCacheManager.shared.cache(with: url) { [weak self] image in
                guard let image = image else {
                    return
                }
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
    
    func cacheImage(url: URL) {
        ImageCacheManager.shared.cache(with: url) { [weak self] image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
