//
//  ParentObservableObject.swift
//  SwiftUIDataFlow
//
//  Created by Ahmed Mgua on 28/11/22.
//

import Foundation

class ParentObservableObject: ObservableObject {
    private let messages: [String] = ["Hello", "Ciao", "Ola"]
    @Published var message: String = "Hi"
    
    func updateMessage() {
        // Some logic here eg a network request.
        // After the logic is complete, update the message with the new one.
        message = messages.randomElement()!
    }
}
