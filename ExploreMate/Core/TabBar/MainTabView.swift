//
//  MainTabView.swift
//  ExploreMate
//
//  Created by Jonathan Lin on 2024-04-17.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CardStackView()
                .tabItem { Image(systemName: "hare") }
                .tag(0)
            Text("Matches View")
                .tabItem { Image(systemName: "pin") }
                .tag(1)
        }
        .padding(.horizontal)
        .tint(.primary)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
