//
//  Food.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 17/11/2021.
//

import Foundation

struct Food: Identifiable {
    var id: UUID
    var name: String
    var details: String
    var options: [OptionGroup]
    var extras: [Extra]
    var price: Double
    var imageURL: String
    var stockQuantity: Int
}

//  MARK: -    Equatable Conformance
extension Food:  Equatable   {
    static func ==(lhs: Food, rhs: Food) -> Bool    {
        lhs.id == rhs.id
    }
}

//  MARK: -    Codable Conformance
extension Food:  Codable {
    enum CodingKeys:    CodingKey   {
        case id,
             name,
             details,
             options,
             extras,
             price,
             imageURL,
             stockQuantity
    }

    func encode(to    encoder:    Encoder)    throws    {
        var container    =    encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id,    forKey:    .id)
        try container.encode(name, forKey: .name)
        try container.encode(details, forKey: .details)
        try container.encode(options, forKey: .options)
        try container.encode(extras, forKey: .extras)
        try container.encode(price, forKey: .price)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(stockQuantity, forKey: .stockQuantity)
    }

    init(from decoder:    Decoder)    throws    {
        let container    =    try    decoder.container(keyedBy: CodingKeys.self)

        id    =    try container.decode(UUID.self,    forKey:    .id)
        name    =    try    container.decode(String.self, forKey: .name)
        details    =    try    container.decode(String.self, forKey: .details)
        options =   try container.decode([OptionGroup].self, forKey: .options)
        extras =   try container.decode([Extra].self, forKey: .options)
        price    =    try container.decode(Double.self, forKey: .price)
        imageURL    =    try    container.decode(String.self, forKey: .imageURL)
        stockQuantity    =    try    container.decode(Int.self, forKey: .stockQuantity)
    }
}
