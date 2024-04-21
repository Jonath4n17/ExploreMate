//
//  LocationModalView.swift
//  ExploreMate
//
//  Created by Jodie Zhu on 2024-04-20.
//

import SwiftUI

struct LocationModalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentImageIndex = 0;
    let location: Location
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(location.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                }
            }
            .padding([.top, .leading, .trailing])
            
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        Image(location.profileImageURLs[currentImageIndex])
                            .resizable()
                            .scaledToFill()
                            .overlay {
                                ImageScrollingOverlay(currentImageIndex: $currentImageIndex, imageCount: location.profileImageURLs.count)
                            }
                            .frame(height: SizeConstants.cardHeight / 2.5)
                            .clipped()
                        
                        CardImageIndicatorView(currentImageIndex: currentImageIndex, imageCount: location.profileImageURLs.count)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description")
                            .fontWeight(.semibold)
                        Text("Test description")
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    LocationModalView(location: MockData.locations[0])
}
