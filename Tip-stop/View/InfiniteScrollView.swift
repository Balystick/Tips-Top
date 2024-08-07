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
        ZStack {
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
                
                // Navigation buttons
                Button(action: {
                    path.append("DecouverteView")
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.001))
                            .frame(width: 75, height: 75)
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                    .position(x: 50, y: 75)
                }
                
//                Button(action: {
//                    path.append("ProfileView")
//                }) {
//                    ZStack {
//                        Circle()
//                            .fill(Color.black.opacity(0.001))
//                            .frame(width: 75, height: 75)
//                        Image(systemName: "person.crop.circle")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 37, height: 37)
//                            .foregroundColor(.white)
//                    }
//                    .position(x: UIScreen.main.bounds.width - 50, y: 75)              
//                }
            }
            
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}
