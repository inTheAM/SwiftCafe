//
//  View.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import SwiftUI

extension View    {    
    func overlayDivider()    ->    some View    {
        return self.overlay(Divider(),    alignment: .bottom)
    }
}
