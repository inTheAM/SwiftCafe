//
//  ListeningChildView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct ListeningChildView: View {
    let currentMessage: String
    var body: some View {
        Text("The current message is: " + currentMessage)
    }
}

struct ListeningChildView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
