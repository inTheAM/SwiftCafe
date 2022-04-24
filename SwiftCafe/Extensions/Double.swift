//
//  Double.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation

extension Double {
    /// Formats a double to the specified decimal places and returns it as a String.
    /// - Parameter places: the number of decimal places to format the Double.     /// - Returns: A String interpolation of the Double formatted to the specified decimal places.
    func format(_    places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
