//
//  User.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-18.
//

import Foundation

struct Location: Identifiable, Hashable {
    let id: String
    let name: String
    let address: String
    var profileImageURLs: [String]
}
