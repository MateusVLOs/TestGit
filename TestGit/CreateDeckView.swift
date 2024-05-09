//
//  CreateDeckView.swift
//  TestGit
//
//  Created by Mateus Assis on 29/04/24.
//

import PhotosUI
import SwiftUI

struct CreateDeckView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var contentViewViewModel: ContentView.ViewModel
    @StateObject var viewModel = ViewModel()
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var deckCover: Image?
    
    let categories = ["Personalizado", "Filmes/Séries", "Vídeo Game", "Anime"]
    
    var body: some View {
        NavigationStack {
            Form {
                PhotosPicker(selection: $pickerItem) {
                    if let deckCover {
                        Spacer()
                        
                        deckCover
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 150)
                            .clipShape(.rect(cornerRadius: 5))
                        
                        Spacer()
                    } else {
                        VStack {
                            HStack {
                                Spacer()
                                
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.gray)
                                    .frame(width: 80)
                                
                                Spacer()
                            }
                            
                            Text("Selecione uma foto")
                                .font(.title2)
                                .bold()
                            
                            Text("Toque para selecionar uma foto")
                                .font(.headline)
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical)
                    }
                }
                .buttonStyle(.plain)
                .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                
                TextField("Nome", text: $viewModel.deckName)
                
                Picker("Categoria", selection: $viewModel.category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                
                List {
                    Section {
                        // Fazer tratamento para quando adicionar uma carta limpar o campo
                        TextField("Nome da carta", text: $viewModel.cardName)
                        Button("Adicionar carta") {
                            viewModel.deckCards.append(viewModel.cardName)
                        }
                    } header: {
                        // Melhorar esse texto deixar mais padronizado com DatailDeckView
                        Text("Criar cartas")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                    }
                    
                    Section {
                        ForEach(viewModel.deckCards.reversed(), id: \.self) {
                            Text($0)
                                .bold()
                        }
                        .onDelete { indexSet in
                                viewModel.deckCards.remove(atOffsets: indexSet)
                        }
                    }
                }
            }
            .navigationTitle("Cria Deck")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: pickerItem) { _ in
                loadImage()
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Criar") {
                        // Logica de criar deck
                        let newDeck = viewModel.createDeck()
                        contentViewViewModel.saveDeck(deck: newDeck.0, cover: newDeck.1)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .preferredColorScheme(.dark)
            .background(Color(red: 0.1, green: 0.1, blue: 0.1))
            .scrollContentBackground(.hidden)
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await pickerItem?.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: imageData) else { return }
            viewModel.coverImageData = imageData
            deckCover = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    CreateDeckView(contentViewViewModel: ContentView.ViewModel())
}
