//
//  LocationButton.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import SwiftUI

struct LocationButton: View {
    @State private var showLocation = false
    var body: some View {
        Button(action: {
            showLocation = true
        })    {
            HStack {
                Image(systemName: "location.fill")
                    .font(.subheadline)
                Text("Location here")
                
            }.font(.subheadline.bold())
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 5)
        .foregroundColor(.primary)
        .fullScreenCover(isPresented: $showLocation) {
            
        }
    }
}

struct LocationButton_Previews: PreviewProvider {
    static var previews: some View {
        LocationButton()
    }
}
