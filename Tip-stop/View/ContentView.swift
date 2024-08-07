//
//  ContentView.swift
//  Tip-stop
//
//  Modified par Aurélien on 18/07/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var globalDataModel = GlobalDataModel()
    @State private var path = NavigationPath()
    @State private var showOnboarding = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.white // Force le fullscreen de la zone d'affichage
                    .ignoresSafeArea()
                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Découverte")
                    .fullScreenCover(isPresented: $showOnboarding) {
                        OnboardingPageView()
                    }
                    .navigationDestination(for: String.self) { value in
                        switch value {
                        case "DecouverteView":
                            DecouverteView(path: $path, globalDataModel: globalDataModel)
                        case "InfiniteScrollView:Productivité":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Productivité")
                        case "InfiniteScrollView:Personnalisation":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Personnalisation")
                        case "InfiniteScrollView:Utilisation Avancée":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Utilisation Avancée")
                        case "InfiniteScrollView:Sécurité & Confidentialité":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Sécurité & Confidentialité")
                        case "InfiniteScrollView:Connectivité et Communication":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Connectivité et Communication")
                        case "InfiniteScrollView:Multimédia":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Multimédia")
                        case "InfiniteScrollView:Accessibilité":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Accessibilité")
                        case "InfiniteScrollView:Batterie et Performances":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Batterie et Performances")
                        case "InfiniteScrollView:Nouveautés":
                            InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Nouveautés")
                        case "Discussions":
                            ListTopicView(path: $path, globalDataModel: globalDataModel)
//                        case "ProfileView":
//                            ProfileView()
                            //                    case "DiscussionView":
                            //                        DiscussionView(path: $path, globalDataModel: globalDataModel)
                            //                    case "StepsView":
                            //                        StepsView(path: $path, globalDataModel: globalDataModel)
                            //                    case "CommentsView":
                            //                        CommentsView(path: $path, globalDataModel: globalDataModel)

                        default:
                            Text("Vue inconnue")
                        }
                    }
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
