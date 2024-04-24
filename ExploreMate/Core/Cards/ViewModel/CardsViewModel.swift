//
//  CardsViewModel.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-18.
//

import Foundation

@MainActor
class CardsViewModel: ObservableObject {
    @Published var likedLocations = [Location]()
    @Published var cardModels = [CardModel]()
    @Published var buttonSwipeAction: SwipeAction?
    
    private let service: CardService
    
    init(service: CardService) {
        self.service = service
        Task { await fetchCardModels() }
    }
    
    func fetchCardModels() async {
        do {
            self.cardModels = try await service.fetchCardModels()
            print("DEBUG: FETCHED CARD MODELS \(self.cardModels)")
        } catch {
            print("DEBUG: Failed to fetch cards with error: \(error)")
        }
    }
    
    func removeCard(_ card: CardModel) {
        guard let index = cardModels.firstIndex(where: {$0.id == card.id}) else {return}
        cardModels.remove(at: index)
    }
}
