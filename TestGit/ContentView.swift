//
//  ContentView.swift
//  TestGit
//
//  Created by Mateus Assis on 16/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
//    @State private var decks = Deck.exampleDecks
//    @State private var serachText = ""
    @State private var showingCreateDeck = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                NavigationLink(destination: DetailDeckView(deck: viewModel.localDecks[0])) {
                    CoverView(deck: viewModel.localDecks[0], isHighlight: true)
                        .padding()
                }
                
                LazyVStack(spacing: 25) {
                    DecksStack(category: "Meus Decks", decks: viewModel.localDecks.reversed())
                    
                    DecksStack(category: "Filmes / Serie", decks: viewModel.localDecks)
                    
                    DecksStack(category: "Customizado", decks: viewModel.localDecks)
                    
                    DecksStack(category: "Anime", decks: viewModel.localDecks)
                }
            }
            .navigationTitle("iGuess")
            .searchable(text: $viewModel.serachText)
            .toolbar {
                Button("jogar deck aleatorio", systemImage: "shuffle") {
                    let url = URL.documentsDirectory.appending(path: "message.txt")
                    
                    do {
                        try FileManager.default.removeItem(at: url)
                        print("Message deleted")
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                Button("Criar Deck", systemImage: "plus.circle.fill") {
//                    let data = Data("Test Message".utf8)
//                    let url = URL.documentsDirectory.appending(path: "message.txt")
//                    
//                    do {
//                        try data.write(to: url, options: [.atomic, .completeFileProtection])
//                        let input = try String(contentsOf: url)
//                        print(input)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
                    showingCreateDeck.toggle()
                }
            }
            .task {
                await viewModel.getCloudDecks()
            }
            .sheet(isPresented: $showingCreateDeck) {
                CreateDeckView(contentViewViewModel: viewModel)
            }
            .scrollIndicators(.hidden)
            .preferredColorScheme(.dark)
            .background(Color(red: 0.1, green: 0.1, blue: 0.1))
        }
    }
}

#Preview {
    ContentView()
}
