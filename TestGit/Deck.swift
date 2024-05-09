//
//  Deck.swift
//  TestGit
//
//  Created by Mateus Assis on 23/04/24.
//

import Foundation
//
//class Deck: Codable, Identifiable, Hashable {
//    static func == (lhs: Deck, rhs: Deck) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    var id = UUID()
//    var nome: String
//    var categoria: String
//    var cartas: [String]
//    var foto: String?
//    var isSave: Bool?
//    
//    init(nome: String, categoria: String, cartas: [String], foto: String? = nil, isSave: Bool? = nil) {
//        self.nome = nome
//        self.categoria = categoria
//        self.cartas = cartas
//        self.foto = foto
//        self.isSave = isSave
//    }
//}

struct Deck: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var category: String
    var cards: [String]
    var coverURL: String?
    
    static var exampleDecks: [Deck] {
            return [
                Deck(id: UUID(), name: "Animais", category: "Coisas", cards: ["Gato", "Cachorro", "Golfinho", "Papagaio", "Formiga"], coverURL: "animais"),
                Deck(id: UUID(), name: "Comidas", category: "Coisas", cards: ["Cuscuz", "Linguiça", "Pizza", "Pastel"], coverURL: "comidas"),
                Deck(id: UUID(), name: "Atores de cinema", category: "Coisas", cards: ["Ana de Armas", "Ton Cruise", "Zandaia", "Timote"], coverURL: "cinema"),
                Deck(id: UUID(), name: "Xmen", category: "filme/serie", cards: ["Vampira", "Prof. Xavier", "Ciclope", "Maguineto"], coverURL: "xmen"),
                Deck(id: UUID(), name: "Game of thones", category: "filme/serie", cards: ["Arya", "Sansa", "Bran", "Danyeres"], coverURL: "https://i.insider.com/56cdecd62e526554008b9413?width=1300&format=jpeg&auto=webp"),
                Deck(id: UUID(), name: "Naruto shippuden", category: "Anime", cards: ["Naruto", "Hinata", "Sakura", "Sasuke", "Itachi", "Tsunade"], coverURL: "https://cdn.europosters.eu/image/1300/posters/naruto-shippuden-i84239.jpg")
                
            ]
        }
}
