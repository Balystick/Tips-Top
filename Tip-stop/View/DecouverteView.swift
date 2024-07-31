//
//  DecouverteView.swift
//  Tip-stop
//
//  Created by Aurélien on 18/07/2024.
//
import SwiftUI

struct DecouverteView: View {
    @StateObject private var viewModel = DecouverteViewModel()
    @State private var activeID: UUID?
    @State private var carouselImages: [CarouselImage] = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                CarouselView(
                    scaleValue: 0.2,
                    imageWidth: 252,
                    spacing: 10,
                    cornerRadius: 30,
                    minimumImageWidth: 40,
                    selection: $activeID,
                    data: carouselImages
                ) { carouselImage in
                    AnyView(
                        GeometryReader { _ in
                            NavigationLink(destination: InfiniteScrollView(categoryID: carouselImage.id)) {
                                Image(carouselImage.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                        }
                        .clipped()
                    )
                }
                .frame(height: 355)
                .animation(.snappy(duration: 0.3, extraBounce: 0), value: activeID)
                .padding(.top, 20)
                
                Spacer()
            }
            .navigationTitle("Découverte")
            .onAppear {
                carouselImages = viewModel.getCarouselImages()
            }
        }
    }
}

#Preview {
    DecouverteView()
}
