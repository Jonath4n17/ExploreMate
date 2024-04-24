//
//  ListView.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-22.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: CardsViewModel

    var body: some View {
        VStack {
            Text("Location Matches")
                .font(.title)
                .fontWeight(.semibold)
            
            List {
    //            ForEach(viewModel.likedLocations) { location in
    //                Text(location.name)
    //            }
                HStack {
                    Text("TEST")
                    Spacer()
                    Button {
                        print("DEBUG: PRESSED")
                    } label: {
                        Image(systemName: "arrow.up.circle")
                            .fontWeight(.heavy)
                            .imageScale(.large)
                    }
                }
                Text("TEST")
            }
        }
    }
}

#Preview {
    ListView(viewModel: CardsViewModel(service: CardService()))
}
