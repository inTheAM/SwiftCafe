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
    ///
    /// If the value will never change, use a `let` to declare it:
    ///
    ///     let message: String = "Hello"
    @State private var message: String = "Hi"
    
    /// An array of sample messages to display.
    let messages: [String] = ["Hello", "Ciao", "Ola"]
    
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
    
    /// Sets a random message to display.
    /// Generally, it's a good idea to create functions for any logic you use, rather than put the logic directly inside the button.
    func setRandomMessage() {
        message = messages.randomElement()!
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
