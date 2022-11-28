//
//  ListeningChildView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct ListeningChildView: View {
    /// This view only displays the value from the parent view.
    /// Since this view is not interested in modifying the value, `let` is more fitting here.
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
