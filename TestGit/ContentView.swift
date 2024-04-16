//
//  ContentView.swift
//  TestGit
//
//  Created by Mateus Assis on 16/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Section {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.fixed(20))]) {
                            ForEach(0..<5) { _ in
                                Rectangle()
                                    .fill(.blue)
                                    .frame(width: 100, height: 150)
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("APP Name")
            .toolbar {
                Button("jogar deck aleatorio", systemImage: "shuffle") {
                    
                }
                Button("Criar Deck", systemImage: "plus") {
                    
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
