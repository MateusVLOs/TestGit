//
//  CreateDeckView-ViewModel.swift
//  TestGit
//
//  Created by Mateus Assis on 04/05/24.
//

import Foundation

extension CreateDeckView {
    class ViewModel: ObservableObject {
        @Published var deckName = ""
        @Published var cardName = ""
        @Published var category = "Personalizado"
        var coverImageData: Data?
        
        @Published var deckCards: [String] = []
        
        func createDeck() -> (Deck, Data?) {
            guard coverImageData != nil else {
                return (Deck(id: UUID(), name: deckName, category: category, cards: deckCards), nil)
            }
            
            let coverName = cardName + "Cover"
            let newDeck = Deck(id: UUID(), name: deckName, category: category, cards: deckCards, coverURL: coverName)
            return (newDeck, coverImageData)
        }
    }
}
