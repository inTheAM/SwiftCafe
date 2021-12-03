//
//  ImageAsync.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

struct ImageAsync: View {
    @ObservedObject    var remoteImage: RemoteImage

    init(imageURL: String) {
        self.remoteImage    =    .init(imageURL: imageURL)
    }

    var body: some View {
        if remoteImage.isLoaded {
            Image(uiImage: remoteImage.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
        } else {
            ZStack {
                Rectangle()
                    .redacted(reason: .placeholder)
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

struct ImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        ImageAsync(imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU")
    }
}
