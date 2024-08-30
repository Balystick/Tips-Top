
//
//  CarouselView.swift
//  Tip-stop
//
//  Created by Aurélien on 30/07/2024.
//
import SwiftUI

/// `CarouselView` est une vue personnalisée pour afficher un carrousel d'images.
/// Elle permet de redimensionner et d'aligner les images en fonction de la position de défilement.
struct CarouselView: View {
    var scaleValue: CGFloat
    var imageWidth: CGFloat
    var spacing: CGFloat
    var cornerRadius: CGFloat
    var minimumImageWidth: CGFloat
    @Binding var selection: UUID?
    var data: [CarouselImage]
    var content: (CarouselImage) -> AnyView
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ScrollView(.horizontal) {
                HStack(spacing: spacing) {
                    ForEach(data) { item in
                        ItemView(item)
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, max((size.width - imageWidth) / 2, 0))
            .scrollPosition(id: $selection)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollIndicators(.hidden)
        }
    }
    
    /// Génère une vue pour un élément du carrousel avec les effets de redimensionnement et de décalage.
    /// - Parameter item: L'image du carrousel à afficher.
    /// - Returns: Une vue pour l'image du carrousel.
    func ItemView(_ item: CarouselImage) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            let progress = minX / (imageWidth + spacing)
            
            let diffWidth = imageWidth - minimumImageWidth
            let reducingWidth = progress * diffWidth
            let cappedWidth = min(reducingWidth, diffWidth)
            
            let resizedFrameWidth = size.width - (minX > 0 ? cappedWidth : min(-cappedWidth, diffWidth))
            let negativeProgress = max(-progress, 0)
            
            let scaledValue = scaleValue * abs(progress)
            
            content(item)
                .frame(width: size.width, height: size.height)
                .frame(width: resizedFrameWidth)
                .scaleEffect(1 - scaledValue)
                .mask {
                    let scaledHeight = (1 - scaledValue) * size.height
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(height:  max(scaledHeight, 0))
                }
                .offset(x: -reducingWidth)
                .offset(x: min(progress, 1) * diffWidth)
                .offset(x: negativeProgress * diffWidth)
        }
        .frame(width: imageWidth)
    }
}

#Preview {
    DecouverteView(path: .constant(NavigationPath()), globalDataModel: GlobalDataModel())
}
