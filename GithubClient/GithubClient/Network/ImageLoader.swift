//
//  ImageLoader.swift
//  GithubClient
//
//  Created by Денис Ефименков on 03.09.2025.
//

import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cached = cache.object(forKey: urlString as NSString) {
            completion(cached)
            return
        }
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            var image: UIImage? = nil
            if let data = data {
                image = UIImage(data: data)
                if let img = image {
                    self?.cache.setObject(img, forKey: urlString as NSString)
                }
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
