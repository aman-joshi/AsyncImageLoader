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
  var showProgress:Bool

  public init(url: String, placeholder: Image = Image(systemName: "photo"),showProgress:Bool = false) {
    self.placeholder = placeholder
    self.showProgress = showProgress
    self.imageLoader.load(url: url)
  }

  public var body: some View {
    if let uiImage = self.imageLoader.downloadedImage {
      Image(uiImage: uiImage).resizable()
    }else {
      if showProgress {
        ZStack(alignment: .center) {
          placeholder.resizable().blur(radius: 3)
          ActivityIndicator(style: .large)
        }
      }else {
        placeholder.resizable()
      }
    }
  }
}
