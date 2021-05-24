//
//  AsyncImage.swift
//  
//
//  Created by Aman Joshi on 24/05/21.
//

import SwiftUI

@available(iOS 13.0, *)
public struct AsyncImage: View {

  @ObservedObject private var imageLoader = ImageLoader()

  var placeholder: Image

  public init(url: String, placeholder: Image = Image(systemName: "photo")) {
    self.placeholder = placeholder
    self.imageLoader.load(url: url)
  }

    public var body: some View {
      if let uiImage = self.imageLoader.downloadedImage {
        return Image(uiImage: uiImage).resizable()
      } else {
        return placeholder.resizable()
      }
    }
}
