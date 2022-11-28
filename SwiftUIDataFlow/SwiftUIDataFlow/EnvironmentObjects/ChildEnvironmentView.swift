//
//  ChildEnvironmentView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct ChildEnvironmentView: View {
    
    /// To access an object injected into the environment, use `@EnvironmentObject`.
    /// This works the same way as `@ObservedObject`, except that the object does not need to be passed explicitly in the initializer.
    @EnvironmentObject var parentModel: ParentObservableObject
    
    var body: some View {
        
        VStack {
            
            // Update the message in the model, which will be reflected in the parent view.
            Button("Update message") {
                parentModel.updateMessage()
            }
            .padding()
            
            // The environment object will be accessible also to child views of this view without passing it directly.
            GrandchildEnvironmentView()
                .padding()
        }
    }
}

struct ChildEnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentEnvironmentView()
    }
}
