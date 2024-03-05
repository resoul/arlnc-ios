//
//  ImageCacheManager.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let imageCache = NSCache<NSString, UIImage>()

    func cache(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }

                DispatchQueue.main.async {
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image)
                }
            }.resume()
        }
    }
}
