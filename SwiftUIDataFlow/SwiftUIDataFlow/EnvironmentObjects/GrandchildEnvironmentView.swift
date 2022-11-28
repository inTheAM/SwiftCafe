//
//  GrandchildEnvironmentView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct GrandchildEnvironmentView: View {
    @EnvironmentObject var parentModel: ParentObservableObject
    
    var body: some View {
        Text("The current message is: " + parentModel.message)
    }
}

struct GrandchildEnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        GrandchildEnvironmentView()
    }
}
