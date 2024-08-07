//
//  DecouverteView.swift
//  Tip-stop
//
//  Created by Aurélien on 18/07/2024.
//
import SwiftUI

/// `DecouverteView` est la vue qui affiche les catégories d'astuce.
/// Elle utilise un carrousel pour afficher les images des catégories.
struct DecouverteView: View {
    @Binding var path: NavigationPath
    @ObservedObject var globalDataModel: GlobalDataModel
    @StateObject private var viewModel: DecouverteViewModel
    @State private var activeID: UUID?  // Identifiant de l'image active dans le carrousel
    @State private var carouselImages: [CarouselImage] = []
    
    init(path: Binding<NavigationPath>, globalDataModel: GlobalDataModel) {
        self._path = path
        self.globalDataModel = globalDataModel
        self._viewModel = StateObject(wrappedValue: DecouverteViewModel(globalDataModel: globalDataModel))
    }
    
    var body: some View {
        VStack {
            CarouselView(
                scaleValue: 0.2,
                imageWidth: 250,
                spacing: 10,
                cornerRadius: 30,
                minimumImageWidth: 40,
                selection: $activeID,
                data: carouselImages
            ) { carouselImage in
                AnyView(
                    GeometryReader { _ in
                        Button(action: {
                            path.append("InfiniteScrollView:\(carouselImage.categorieTitre)")
                        }) {
                            Image(carouselImage.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                        .clipped()
                )
            }
            .frame(height: 350)
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: activeID)
            .padding(.top, 20)
            
            Spacer()
            
            Button(action: {
                path.append("InfiniteScrollView:Nouveautés")
            }) {
                Image("Nouveautés")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            
            Spacer()
            
            Button(action: {
                path.append("Discussions")
            }) {
                Image("Discussions")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    path.removeLast()
                }) {
                    Image(systemName: "arrow.uturn.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color(white: 0.2))
                }
            }
        }
        .onAppear {
            carouselImages = viewModel.getCarouselImages() // Récupère les images du carrousel à l'apparition de la vue
            DispatchQueue.main.async { // Prévient une erreur de mise à jour de l'interface
                if !carouselImages.isEmpty {
                    let middleIndex = carouselImages.count / 2   // Calcul de l'index du milieu
                    activeID = carouselImages[middleIndex].id  // Définit l'image active à l'index du milieu
                }
            }
        }
    }
}


#Preview {
    DecouverteView(path: .constant(NavigationPath()), globalDataModel: GlobalDataModel())
}
