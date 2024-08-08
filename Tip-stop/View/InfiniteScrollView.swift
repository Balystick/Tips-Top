//
//  InfiniteScroll.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//
import SwiftUI

struct InfiniteScrollView: View {
    @StateObject private var viewModel = InfiniteScrollViewModel()
    @State var categoryTitre: String
    @State private var currentIndex: Int = 0
    
    @State private var showingSheet = false
    
    var body: some View {
        GeometryReader { geometry in
            TabView(selection: $currentIndex) {
                ForEach(Array(viewModel.astuces.enumerated()), id: \.element.id) { index, astuce in
                    ZStack{
                        AstuceView(astuce: astuce)
                            .tag(index)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .onAppear {
                                if index == viewModel.astuces.count - 1 {
                                    viewModel.loadMoreAstuces()
                                }
                            }

                        Button("?") {
                            showingSheet.toggle()
                        }
                        .frame(width: 200, height: 400)
                        .sheet(isPresented: $showingSheet) {
                            StepsView()
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
        }
        //            .onTapGesture {
        //                showingSheet.toggle()
        //            }
        //            .sheet(isPresented: $showingSheet) {
        //                 StepsView()
        //             }
    }
}

//#Preview {
//    InfiniteScrollView(categoryTitre: "Catégorie")
//}
