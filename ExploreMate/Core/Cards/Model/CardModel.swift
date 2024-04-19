//
//  CardModel.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-18.
//

import Foundation

struct CardModel {
    let location: Location
}

extension CardModel: Identifiable, Hashable {
    var id: String { return location.id }
}
