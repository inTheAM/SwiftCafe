//
//  ChildView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct BindingChildView: View {
    /// To use a `State` variable  from a parent view we have two options.
    /// If we would like to modify the variable,  we use `@Binding`
    @Binding var message: String
    
    let messages: [String] = ["Hello", "Ciao", "Ola"]
    
    var body: some View {
        
        // We can then modify the binding variable as we wish.
        Button("Set message") {
            message = messages.randomElement()!
        }
    }
}

struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
