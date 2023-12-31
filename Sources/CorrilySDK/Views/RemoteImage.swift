//
//  File.swift
//  
//
//  Created by Thành Trang on 11/12/2023.
//

import SwiftUI

class ImageLoader: ObservableObject {
  @Published var image: UIImage = UIImage()
  
  func loadImage(for urlString: String) {
    guard let url = URL(string: urlString) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self.image = UIImage(data: data) ?? UIImage()
      }
    }
    task.resume()
  }
  
}

@available(iOS, deprecated: 15.0, message: "Use the built-in AsyncImage instead")
struct RemoteImage: View {
  @ObservedObject var imageLoader = ImageLoader()
  @State var image: UIImage = UIImage()
  
  init(url: String) {
    imageLoader.loadImage(for: url)
  }
  
  var body: some View {
    Image(uiImage: image)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .onReceive(imageLoader.$image) { image in
        self.image = image
      }
  }
}
