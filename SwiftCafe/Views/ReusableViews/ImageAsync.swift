//
//  ImageAsync.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

struct ImageAsync:    View    {
    @ObservedObject    var remoteImage:    RemoteImage
    @Binding var accentColor:    Color?
    
    init(imageURL:    String,    accentColor:    Binding<Color?>    =    .constant(nil))    {
        self.remoteImage    =    .init(imageURL: imageURL)
        self._accentColor    =    accentColor
    }
    
    var body: some View    {
//        if remoteImage.isLoaded    {
            Image(uiImage: remoteImage.image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
//        }    else    {
//            ZStack {
//                Rectangle()
//                    .redacted(reason: .placeholder)
//                    .foregroundColor(.gray)
//                    .aspectRatio(contentMode: .fit)
//                    .opacity(0.5)
//                Image(systemName: "photo")
//                    .renderingMode(.original)
//            }
//        }
    }
}

struct ImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        ImageAsync(imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP68GaMxj6iSn18pYEVZyW0lLLYgbEzbdmFQ&usqp=CAU")
    }
}
