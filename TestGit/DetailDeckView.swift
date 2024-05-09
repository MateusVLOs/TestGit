//
//  DetailDeckView.swift
//  TestGit
//
//  Created by Mateus Assis on 30/04/24.
//

import SwiftUI

struct DetailDeckView: View {
    
    var deck: Deck
    @State private var cardsAmount = 5
    @State private var time = 60
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                CoverView(deck: deck, isHighlight: true)
                    .padding()
                
                Text(deck.name)
                    .font(.largeTitle)
                    .bold()
                
                Button("Jogar") {
                    // Começar jogo
                }
                .font(.title.bold())
                .foregroundStyle(.black)
                .frame(width: 200, height: 50)
                .background(.white)
                .clipShape(.rect(cornerRadius: 10))
                
                VStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Quantidade de carta")
                            .bold()
                        
                        Stepper("\(cardsAmount) cartas", value: $cardsAmount, in: 1...deck.cards.count)
                            .padding(10)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Tempo")
                            .bold()
                        
                        Stepper("\(time) segundos", value: $time, in: 60...120, step: 10)
                            .padding(10)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Deck")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Condições de baixar
                // intanciar uma listas dos decks locais e ver se está nessa lista
                Button("Baixar", systemImage: "arrow.down.circle.fill") {
                    
                }
            }
            .preferredColorScheme(.dark)
            .background(Color(red: 0.1, green: 0.1, blue: 0.1))
            
        }
    }
}

#Preview {
    DetailDeckView(deck: .exampleDecks[4])
}
