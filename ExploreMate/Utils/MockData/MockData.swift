//
//  MockData.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-18.
//

import Foundation

struct MockData {
    
    static let locations: [Location] = [
        .init(
            id: NSUUID().uuidString,
            name: "Claw And Kitty",
            address: "Highway 7 Markham, Ontario",
            profileImageURLs: ["clawAndKitty","clawAndKitty-2","clawAndKitty-3"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "McDonald's",
            address: "Town Square Markham, Ontario",
            profileImageURLs: ["mcdonalds"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Sussex Park",
            address: "Richmond Hill, Ontario",
            profileImageURLs: ["sussex"]
        ),
    ]
    
}
