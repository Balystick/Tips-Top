//
//  InfiniteScroll.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import SwiftUI

struct InfiniteScrollView: View {
    @Binding var path: NavigationPath
    @ObservedObject var globalDataModel: GlobalDataModel
    @StateObject private var viewModel = InfiniteScrollViewModel()
    @State var categoryTitre: String
    @State private var currentIndex: Int = 0

    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $currentIndex) {
                ForEach(Array(viewModel.astuces.enumerated()), id: \.element.id) { index, astuce in
                    AstuceView(astuce: astuce)
                        .tag(index)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .onAppear {
                            if index == viewModel.astuces.count - 1 {
                                viewModel.loadMoreAstuces()
                            }
                        }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
        }
    }
}
