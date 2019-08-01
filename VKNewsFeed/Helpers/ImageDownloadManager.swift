//
//  ImageDownloadManager.swift
//  VKNewsFeed
//
//  Created by Serg on 20/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

class ImageDownloadManager {
    static let instance = ImageDownloadManager()
    private var downloadDictionary = [UIImageView: URLSessionTask]()
    private var imageCache = [String: UIImage]()
}

extension ImageDownloadManager {
    func setImage(toImageView: UIImageView, urlString: String?) {
        guard let urlString = urlString else {
            downloadDictionary[toImageView]?.cancel()
            toImageView.image = nil
            return
        }
        
        guard let task = downloadDictionary[toImageView] else {
            load(toImageView: toImageView, urlString: urlString)
            return
        }
        
        task.cancel()
        load(toImageView: toImageView, urlString: urlString)
    }
}

extension ImageDownloadManager {
    private func load(toImageView: UIImageView, urlString: String) {
        if let savedImage = imageCache[urlString] {
            toImageView.image = savedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            print("неверный url \(urlString)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                // todo
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                toImageView.image = image
            }
            
            DispatchQueue.main.async {
                self.imageCache[urlString] = image
            }
        }
        
        DispatchQueue.main.async {
            self.downloadDictionary[toImageView] = task
        }
        task.resume()
    }
}
