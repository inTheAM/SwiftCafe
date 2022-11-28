//
//  ChildObservedView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct ChildObservedView: View {
    
    /// To receive an observable object from a parent view, use `@ObservedObject`.
    /// In this case, whenever we use the child view, it will be required to pass in the object using the initializer, as seen in the parent view.
    @ObservedObject var parentModel: ParentObservableObject
    var body: some View {
        
        // Update the message in the model, which will be reflected in the parent view.
        Button("Update message") {
            parentModel.updateMessage()
        }
    }
}

struct ChildObservedView_Previews: PreviewProvider {
    static var previews: some View {
        ParentObservableView()
    }
}
