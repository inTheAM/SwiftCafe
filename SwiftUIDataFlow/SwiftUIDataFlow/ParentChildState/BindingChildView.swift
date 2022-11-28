//
//  ChildView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct BindingChildView: View {
    /// To use a `State` variable  from a parent view that will be modified, use `@Binding`
    /// Any changes made to the binding will be propagated to the parent view.
    @Binding var message: String
    
    let messages: [String] = ["Hello", "Ciao", "Ola"]
    
    var body: some View {
        
        // We can then modify the binding variable as we wish.
        Button("Set message") {
            setRandomMessage()
        }
    }
    
    func setRandomMessage() {
        message = messages.randomElement()!
    }
}

struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
