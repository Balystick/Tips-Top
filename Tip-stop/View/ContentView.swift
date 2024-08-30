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
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var favoriteVideoSelected: String? = nil

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.white // Force le fullscreen de la zone d'affichage
                    .ignoresSafeArea()
                if !hasSeenOnboarding {
                    OnboardingPageView()
                } else {
                    InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                        .navigationDestination(for: String.self) { value in
                            switch value {
                            case "DecouverteView":
                                DecouverteView(path: $path, globalDataModel: globalDataModel)
                            case "InfiniteScrollView:Productivité":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Productivité", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Personnalisation":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Personnalisation", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Utilisation Avancée":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Utilisation Avancée", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Sécurité & Confidentialité":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Sécurité & Confidentialité", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Connectivité et Communication":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Connectivité et Communication", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Multimédia":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Multimédia", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Accessibilité":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Accessibilité", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Batterie et Performances":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Batterie et Performances", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Nouveautés":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Nouveautés", favoriteVideoSelected: $favoriteVideoSelected, hasSeenOnboarding: $hasSeenOnboarding)
                            case "Discussions":
                                ListTopicView(path: $path, globalDataModel: globalDataModel)
                            case "ProfileView":
                                ProfileView(path: $path, globalDataModel: globalDataModel, favoriteVideoSelected: $favoriteVideoSelected)
                            default:
                                Text("Vue inconnue")
                            }
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

