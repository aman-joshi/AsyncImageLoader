//
//  ImageLoader.swift
//  
//
//  Created by Aman Joshi on 24/05/21.
//

import Foundation
import SwiftUI

let imageCache = NSCache<AnyObject, AnyObject>()

@available(iOS 13.0, *)
class ImageLoader:ObservableObject {

  @Published var downloadedImage: UIImage?

  func load(url: String) {

    if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
      self.downloadedImage = imageFromCache
      return
    }

    guard let imageURL = URL(string: url) else {
      fatalError("ImageURL is not correct!")
    }
    URLSession.shared.dataTask(with: imageURL) { data, response, error in
      guard let data = data, error == nil else {
        return
      }

      DispatchQueue.main.async {
        if let imageToCache = UIImage(data: data) {
          self.downloadedImage = imageToCache
          imageCache.setObject(imageToCache, forKey: url as AnyObject)
        }
      }

    }.resume()

  }
}
