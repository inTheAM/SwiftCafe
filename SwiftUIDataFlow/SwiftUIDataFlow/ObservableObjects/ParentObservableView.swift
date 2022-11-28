//
//  ParentObservableView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct ParentObservableView: View {
    /// Sometimes, the value to be displayed is dependent on some logic being performed before it is shown.
    /// In that case, it is better to extract the `State` variable into an `ObservableObject`.
    /// An `ObservableObject` is an object that publishes changes made in its `@Published` properties.
    ///
    /// To create an instance of an `ObservableObject`, use `@StateObject`.
    @StateObject private var parentModel = ParentObservableObject()
    var body: some View {
        VStack {
            // Display the message in the model.
            Text(parentModel.message)
            
            // The observable object can be passed directly to a child view,
            // which can then access the same logic in the observable object and make changes to it.
            ChildObservedView(parentModel: parentModel)
                .padding()
        }
    }
}

struct ParentObservableView_Previews: PreviewProvider {
    static var previews: some View {
        ParentObservableView()
    }
}
