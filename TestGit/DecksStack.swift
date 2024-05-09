//
//  DecksStack.swift
//  TestGit
//
//  Created by Mateus Assis on 27/04/24.
//

import SwiftUI

struct DecksStack: View {
    var category: String
    var decks: [Deck]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(decks) { deck in
                        NavigationLink(destination: DetailDeckView(deck: deck)) {
                            CoverView(deck: deck, isHighlight: false)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    DecksStack(category: "Anime", decks: [Deck(id: UUID(), name: "Naruto", category: "Anime", cards: ["naruto", "hinata"], coverURL: "avengers")])
}
