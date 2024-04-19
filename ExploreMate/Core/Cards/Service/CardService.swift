//
//  CardService.swift
//  ExploreMate
//
//  Created by Jodie Zhu on 2024-04-18.
//

import Foundation

struct CardService {
    
    func fetchCardModels() async throws -> [CardModel] {
        let locations = MockData.locations
        return locations.map({ CardModel(location: $0)})
    }
}
