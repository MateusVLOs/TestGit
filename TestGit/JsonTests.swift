//
//  JsonTests.swift
//  TestGit
//
//  Created by Mateus Assis on 28/04/24.
//

import SwiftUI

struct JsonTests: View {
    
    @State private var decksAdd: [Deck] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                DecksStack(category: "Do JSON", decks: decksAdd)
            }
            .onAppear(perform: loadLocalData)
            .toolbar {
                Button("Add deck") {
                    
                    let newDeck = Deck(id: UUID(), name: "New deck", category: "Test", cards: ["card1", "card2", "card3"], coverURL: "https://assets-prd.ignimgs.com/2021/08/09/dune-insta-vert-main-dom-1638x2048-1628522913715.jpg")
                    
                    decksAdd.append(newDeck)
                    print("deck added")
                }
                
                Button("salvar deck") {
                    save()
                }
            }
        }
    }
    
    func loadLocalData() {
        
//        print("load loacal data start")
//        guard let url = Bundle.main.url(forResource: "decks.json", withExtension: nil) else {
//            fatalError("Failed to locate decks.json from bundle.")
//        }
//        
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load decks.json from bundle.")
//        }
//        
//        do {
//            self.decksAdd = try JSONDecoder().decode([Deck].self, from: data)
//        } catch {
//            print("cannot decode deck.json")
//        }
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("savedDecks.json")
        
        // Verifica se o arquivo já existe no diretório de documentos
        if !fileManager.fileExists(atPath: fileURL.path) {
            // Se não existir, copia o arquivo JSON do bundle principal para o diretório de documentos
            if let bundleURL = Bundle.main.url(forResource: "defaultDecks", withExtension: "json") {
                do {
                    try fileManager.copyItem(at: bundleURL, to: fileURL)
                    print("Arquivo JSON copiado com sucesso para: \(fileURL)")
                } catch {
                    print("Erro ao copiar o arquivo JSON: \(error)")
                    return
                }
            } else {
                print("Arquivo JSON não encontrado no bundle principal.")
                return
            }
        }
        
        // Decodifica o arquivo JSON em uma estrutura
        do {
            let jsonData = try Data(contentsOf: fileURL)
            self.decksAdd = try JSONDecoder().decode([Deck].self, from: jsonData)
            print("Dados decodificados com sucesso.")
        } catch {
            print("Erro ao decodificar o arquivo JSON: \(error)")
        }
    }
    
    func save() {
        
        //guard let savePath = Bundle.main.url(forResource: "decks.json", withExtension: nil) else { return }
        
        do {
            let savePath = URL.documentsDirectory.appending(path: "savedDecks.json")
            
            let data = try JSONEncoder().encode(decksAdd)
            try data.write(to: savePath)
            print("Deck saved.")
        } catch {
            print("Unable to save data.")
        }
    }
    
    
}

#Preview {
    JsonTests()
}
