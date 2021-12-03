//
//  RemoteImage.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

final class RemoteImage: ObservableObject {
    let imageURL: String
    @Published var image    =    UIImage()
    @Published var isLoaded    =    false

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

extension RemoteImage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageURL)
    }
}

extension RemoteImage: Equatable {
    static func == (lhs: RemoteImage, rhs: RemoteImage) -> Bool {
        lhs.imageURL    ==    rhs.imageURL
    }
}
