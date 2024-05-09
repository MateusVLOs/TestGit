//
//  ContentView-ViewModel.swift
//  TestGit
//
//  Created by Mateus Assis on 03/05/24.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var localDecks: [Deck] = []
        @Published var cloudDecks: [Deck] = []
        @Published var serachText = ""
        
        init() {
            getLocalDecks()
            print("build class")
        }
        
        func getLocalDecks() {
            let fileManager = FileManager.default
            guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Failed to find documents directory.")
                return
            }
            let fileURL = documentsURL.appendingPathComponent("savedDecks.json")
            
            if !fileManager.fileExists(atPath: fileURL.path) {
                copyDefaultDecksToDocumentsDirectory(from: fileURL)
            }
            
            do {
                let jsonData = try Data(contentsOf: fileURL)
                self.localDecks = try JSONDecoder().decode([Deck].self, from: jsonData)
                print("Successfully decoded data.")
            } catch {
                print("Failed to decode JSON data: \(error)")
            }
        }
        
        func copyDefaultDecksToDocumentsDirectory(from fileURL: URL) {
            guard let bundleURL = Bundle.main.url(forResource: "defaultDecks", withExtension: "json") else {
                print("Default decks JSON file not found in main bundle.")
                return
            }
            
            do {
                try FileManager.default.copyItem(at: bundleURL, to: fileURL)
                print("Successfully copied JSON file to: \(fileURL)")
            } catch {
                print("Error copying JSON file: \(error)")
            }
        }
        
        func getCloudDecks() async {
            guard let url = URL(string: "") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                self.cloudDecks = try JSONDecoder().decode([Deck].self, from: data)
            } catch {
                print("Error fetching data from API")
            }
        }
        
        // func de filter decks por categoria e remover os duplicados
        
        // func de determinar qual será o deck de destaque
        
        // func de busca dos decks
        
        func saveDeck(deck: Deck, cover: Data?) {
            let savePath = URL.documentsDirectory.appendingPathComponent("savedDecks.json")
            
            if let coverFileName = deck.coverURL {
                let coverURL = URL.documentsDirectory.appending(path: coverFileName)
                
                do {
                    try cover?.write(to: coverURL)
                } catch {
                    print("Error saving cover")
                    return
                }
            }
            
            do {
                localDecks.append(deck)
                let decksData = try JSONEncoder().encode(localDecks)
                try decksData.write(to: savePath)
            } catch {
                print("Error saving decks")
            }
        }
    }
}
