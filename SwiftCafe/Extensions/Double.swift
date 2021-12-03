//
//  Double.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 03/12/2021.
//

import Foundation

extension Double    {
    func format(_    places:    Int)    ->    String    {
        return String(format: "%.\(places)f", self)
    }
}
