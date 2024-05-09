//
//  SaveImageTest.swift
//  TestGit
//
//  Created by Mateus Assis on 26/04/24.
//

import SwiftUI

struct SaveImageTest: View {
    
    let imagePath = URL.documentsDirectory.appending(path: "image.jpg")
    
    @State private var savedImage: Image?
    
    @State private var decks = [Deck(id: UUID(), name: "LoL", category: "Games", cards: ["jenx", "seila", "kate"], coverURL: "arcane")]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Internet image")
                AsyncImage(url: URL(string: "https://i.insider.com/56cdecd62e526554008b9413?width=1300&format=jpeg&auto=webp")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.rect(cornerRadius: 5))
                        .shadow(radius: 10, x: 0, y: 5)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 200)
                .padding()
                
                
                Text("Local image")
                
                savedImage?
                    .resizable()
                
                
                
                if(true) {
                    AsyncImage(url: URL(string: "not")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 150)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 150)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image("arcane")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 150)
                        .clipShape(.rect(cornerRadius: 5))
                        .shadow(radius: 10, x: 0, y: 5)
                }
            }
            .toolbar {
                Button("save") {
                    Task {
                        await saveImageToDisk()
                    }
                }
                
                Button("load img") {
                    loadImageFromLocalDirectory()
                }
                
                Button("delete") {
                    deleteImage()
                }
            }
        }
        
    }
    
    func saveImageToDisk() async {
        let url = URL.documentsDirectory.appending(path: "image.jpeg")
        
        do {
            guard let imageUrl = URL(string: "https://i.insider.com/56cdecd62e526554008b9413?width=1300&format=jpeg&auto=webp") else {
                print("Invalid URL")
                return
            }
            //let data = try Data(contentsOf: imageUrl)
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            try data.write(to: url, options: .atomic)
            
            print("Image save!")
        } catch {
            print("Erro ao salvar imagem: \(error)")
        }
    }
    
    func deleteImage() {
        do {
            let url = URL.documentsDirectory.appending(path: "image.jpg")
            // Delete the file
            try FileManager.default.removeItem(at: url)
            print("Message deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImageFromLocalDirectory() {
        
        // Carrega a imagem do arquivo
        if let loadedData = try? Data(contentsOf: imagePath) {
            if let loadedImage = UIImage(data: loadedData) {
                // Converte UIImage para Image
                let image = Image(uiImage: loadedImage)
                
                // Atualiza a UI na main queue
                DispatchQueue.main.async {
                    self.savedImage = image
                }
                print("Image loaded")
            } else {
                print("Erro ao criar UIImage a partir dos dados salvos")
            }
        } else {
            print("Erro ao carregar dados da imagem salva")
        }
    }
}

#Preview {
    SaveImageTest()
}
