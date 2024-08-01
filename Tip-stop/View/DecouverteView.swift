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
    @StateObject private var viewModel = DecouverteViewModel()
    @State private var activeID: UUID?  // Identifiant de l'image active dans le carrousel
    @State private var carouselImages: [CarouselImage] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
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
                            NavigationLink(destination: InfiniteScrollView(categoryID: carouselImage.categoryId)) {
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
            }
            .navigationTitle("Découverte")
            .onAppear {
                carouselImages = viewModel.getCarouselImages() // Récupère les images du carrousel à l'apparition de la vue
                DispatchQueue.main.async { // Prévient une erreur de mise à jour de l'interface
                    if !carouselImages.isEmpty {
                        let middleIndex = carouselImages.count / 2   // Calcul de l'index du milieu
                        activeID = carouselImages[middleIndex].id  // Définit l'image active à l'index du milieu
                    }
                }
            }
            VStack {
//             NavigationLink(destination: InfiniteScrollView()) {
                Image("Nouveautés")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
//            }
                Spacer()
            }
        }
    }
}

#Preview {
    DecouverteView()
}
