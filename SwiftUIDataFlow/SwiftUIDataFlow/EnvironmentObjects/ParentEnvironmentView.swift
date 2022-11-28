//
//  ParentEnvironmentView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

// Sometimes, a child view may also contain its own child views.
// For example, View A contains View B which contains View C and so on.
// In order to avoid passing the parentModel to every single child view using the initializer as seen in ParentObservableView,
// use EnvironmentObject instead.
// EnvironmentObjects are acessible from every child view contained inside the view that uses the .environmentObject(_:) modifier.

struct ParentEnvironmentView: View {
    @StateObject private var parentModel = ParentObservableObject()
    
    var body: some View {
        VStack {
            // Display the message in the model.
            Text(parentModel.message)
            
            // The environment object will be accessible to a child view without passing it directly.
            ChildEnvironmentView()
                .padding()
        }
        .environmentObject(parentModel)
        // In the above case, any view contained inside the VStack will have access to the parentModel without explicitly passing the object.
        // IMPORTANT: Use .environmentObject(:_) only once per view hierarchy.
        // It is not necessary to inject it into the environment again in the child views since it will be accessible throughout the view hierarchy.
        // In the above case, the view hierarchy is ParentEnvironmentView -> ChildEnvironmentView -> GrandchildEnvironmentView -> etc etc.
        // Any view within this hierarchy will have access to the environment object.
    }
}

struct ParentEnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentEnvironmentView()
    }
}
