//
//  ContentView.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import SwiftUI

struct ContentView: View {
    
    /// Use `@State` when you want to declare variables that may be changed and are being shown in the view or in a child view.
    /// Whenever the value of a `State` changes, the `body` of the view will be computed again and the updates become visible on screen.
    @State private var message: String = "Hi"
    
    /// An array of sample messages to display.
    let messages: [String] = ["Hello", "Ciao", "Ola"]
    
    /// If the value will never change, use a `let` to declare it:
    ///
    ///     let message: String = "Hello"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            // The current message being displayed.
            Text(message)
                .padding()
            
            Spacer()
            
            // Sets a random message to display.
            Button("Set message") {
                setRandomMessage()
            }
        }
        .padding()
    }
    
    func setRandomMessage() {
        message = messages.randomElement()!
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
