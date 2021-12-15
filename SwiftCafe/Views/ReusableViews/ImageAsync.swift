//
//  ImageAsync.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

/// #A view that shows an image loaded asynchronously from a url.
/// ##Displays a placeholder image while the image is loading.
struct ImageAsync: View {

    /// The `RemoteImage` instance that loads the image from the url.
    @ObservedObject    var remoteImage: RemoteImage

    /// Initializes the `RemoteImage` instance with a url.
    /// - Parameter imageURL: The url to load the image from.
    init(imageURL: String) {
        self.remoteImage    =    RemoteImage(imageURL: imageURL)
    }

    var body: some View {
        if remoteImage.isLoaded {
            Image(uiImage: remoteImage.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
        } else {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.5)
                Image(systemName: "photo")
                    .renderingMode(.original)
                    .foregroundColor(.black.opacity(0.6))
            }
        }
    }
}

// swiftlint:disable line_length
struct ImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        ImageAsync(imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU")
    }
}
