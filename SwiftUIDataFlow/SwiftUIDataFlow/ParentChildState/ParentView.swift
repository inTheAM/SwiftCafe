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
            
            // To pass the State variable to a child view which can update the variable ie is using a Binding,
            // use the $ sign to pass the modifiable state, and not just the contained value.
            BindingChildView(message: $message)
                .padding()
            
            // To pass only the value in the message to a child view, pass in the variable without the $ sign.
            // Because the body is always computed whenever the state variable changes,
            // the value in the child view changes appropriately.
            ListeningChildView(currentMessage: message)
                .padding()
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
