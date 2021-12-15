//
//  RemoteImage.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

/// #A type that handles asynchronous loading of an image from a URL.
final class RemoteImage: ObservableObject {

    /// The url for the image to load.
    let imageURL: String

    /// The image loaded from the url.
    @Published var image    =    UIImage()

    /// The loading state of the image.
    @Published var isLoaded    =    false

// MARK: - Initializer
    /// Initializes a `RemoteImage` instance.
    /// - Parameter imageURL: The url for the image to load.
    init(imageURL: String) {
        self.imageURL    =    imageURL
        guard let url    =    URL(string: imageURL)    else {return}

        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) {    data, _, _    in
                guard let data    =    data    else {return}
                guard let uiImage    =    UIImage(data: data)    else {return}
                DispatchQueue.main.async {
                    self.image    =    uiImage
                    self.isLoaded    =    true
                }
            }.resume()
        }
    }
}

// MARK: - Hashable conformance
extension RemoteImage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageURL)
    }
}

// MARK: - Equatable conformance
extension RemoteImage: Equatable {
    static func == (lhs: RemoteImage, rhs: RemoteImage) -> Bool {
        lhs.imageURL    ==    rhs.imageURL
    }
}
