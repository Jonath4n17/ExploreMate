//
//  CardInfoView.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-17.
//

import SwiftUI

struct CardInfoView: View {
    let location: Location
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(location.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    print("DEBUG: Show popup")
                } label: {
                    Image(systemName: "arrow.up.circle")
                        .fontWeight(.heavy)
                        .imageScale(.large)
                }
            }
            
            Text(location.address)
                .font(.subheadline)
                .lineLimit(2)
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        )
    }
}

struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView(location: MockData.locations[1])
    }
}
