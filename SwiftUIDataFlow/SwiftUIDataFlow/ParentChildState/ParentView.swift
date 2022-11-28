//
//  ParentView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct ParentView: View {
    @State private var message: String = "Hi"
    var body: some View {
        VStack {
            Text(message)
                .padding()
            
            // To pass the State variable to a child view which can modify the variable ie is using a Binding, we use the $ sign to pass the actual state, and not just the contained value.
            BindingChildView(message: $message)
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
