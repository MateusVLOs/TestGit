//
//  CoverView.swift
//  TestGit
//
//  Created by Mateus Assis on 27/04/24.
//

import SwiftUI

struct CoverView: View {
    
    let deck: Deck
    let isHighlight: Bool
    @State private var coverImage: Image?
    
    var body: some View {
        Group {
            if let coverImage = coverImage {
                coverImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: isHighlight ? 150 : 100, height: isHighlight ? 200 : 150)
                    .clipShape(.rect(cornerRadius: 5))
                    .shadow(radius: 10, x: 0, y: 5)
            } else {
                AsyncImage(url: URL(string: deck.coverURL ?? "noImage")) { phase in
                    switch phase {
                    case .empty:
                        // Criar um fundo do tamanho do card
                        ProgressView()
                    case .success(let coverImage):
                        coverImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: isHighlight ? 150 : 100, height: isHighlight ? 200 : 150)
                            .clipShape(.rect(cornerRadius: 5))
                            .shadow(radius: 10, x: 0, y: 5)
                    case .failure:
                        // Refinar deck sem imagem
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: isHighlight ? 150 : 100, height: isHighlight ? 200 : 150)
                            .background(.gray)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(alignment: .bottom) {
                                Text(deck.name)
                                    .bold()
                                    .padding()
                            }
                            .foregroundStyle(.white)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .onAppear(perform: loadImage)
    }
    
    
    func loadImage() {
        guard let coverURL = deck.coverURL else { return }
        
        let url = URL.documentsDirectory.appending(path: coverURL)
        
        if let image = UIImage(named: coverURL) {
            self.coverImage = Image(uiImage: image)
            print("Local assets image loaded.")
        } else {
            if let loadedData = try? Data(contentsOf: url), let loadedImage = UIImage(data: loadedData) {
                self.coverImage = Image(uiImage: loadedImage)
                print("Local image loaded.")
            }
        }
    }
}

#Preview {
    CoverView(deck: Deck(id: UUID(),name: "Animais", category: "variados", cards: ["gato", "cachorro", "girrafa"]), isHighlight: true)
}
