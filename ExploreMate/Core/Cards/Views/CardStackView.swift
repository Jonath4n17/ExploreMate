//
//  CardStackView.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-18.
//

import SwiftUI

struct CardStackView: View {
    @StateObject var viewModel = CardsViewModel(service: CardService())
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ZStack {
                    ForEach(viewModel.cardModels) { card in
                        CardView(viewModel: viewModel, model: card)
                    }
                }
                if !viewModel.cardModels.isEmpty { SwipeActionButtonsView(viewModel: viewModel)
                }
            }
            // Header for now
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 5) {
                        Image(systemName: "hare")
                            .font(.title)
                        Text("ExploreMate")
                            .font(.largeTitle)
                    }
                }
            }
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
