//
//  ContentView.swift
//  Tip-stop
//
//  Modified par Aurélien on 18/07/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var onboardingViewModel = OnboardingViewModel()
    @State private var path = NavigationPath()
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var favoriteVideoSelected: String? = nil

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.white // Force le fullscreen de la zone d'affichage
                    .ignoresSafeArea()
                if !hasSeenOnboarding {
                    if onboardingViewModel.onboardingPages.isEmpty {
                        Text("Chargement en cours...")
                            .font(.headline)
                            .foregroundColor(.gray)
                    } else {
                        OnboardingPageView(onboardingPages: onboardingViewModel.onboardingPages)
                    }
                } else {
                    InfiniteScrollView(path: $path, categoryTitre: "", favoriteVideoSelected: $favoriteVideoSelected)
                        .navigationDestination(for: String.self) { value in
                            switch value {
                            case "DecouverteView":
                                DecouverteView(path: $path)
                            case "InfiniteScrollView:Productivité":
                                InfiniteScrollView(path: $path, categoryTitre: "Productivité", favoriteVideoSelected: $favoriteVideoSelected)
                            case "InfiniteScrollView:Personnalisation":
                                InfiniteScrollView(path: $path, categoryTitre: "Personnalisation", favoriteVideoSelected: $favoriteVideoSelected)
                            case "InfiniteScrollView:Utilisation Avancée":
                                InfiniteScrollView(path: $path, categoryTitre: "Utilisation Avancée", favoriteVideoSelected: $favoriteVideoSelected)
                            case "InfiniteScrollView:Sécurité & Confidentialité":
                                InfiniteScrollView(path: $path, categoryTitre: "Sécurité & Confidentialité", favoriteVideoSelected: $favoriteVideoSelected)
                            case "InfiniteScrollView:Connectivité et Communication":
                                InfiniteScrollView(path: $path, categoryTitre: "Connectivité et Communication", favoriteVideoSelected: $favoriteVideoSelected)
                            case "InfiniteScrollView:Multimédia":
                                InfiniteScrollView(path: $path, categoryTitre: "Multimédia", favoriteVideoSelected: $favoriteVideoSelected)
                            case "InfiniteScrollView:Accessibilité":
                                InfiniteScrollView(path: $path, categoryTitre: "Accessibilité", favoriteVideoSelected: $favoriteVideoSelected)
                            case "InfiniteScrollView:Batterie et Performances":
                                InfiniteScrollView(path: $path, categoryTitre: "Batterie et Performances", favoriteVideoSelected: $favoriteVideoSelected)
                            case "InfiniteScrollView:Nouveautés":
                                InfiniteScrollView(path: $path, categoryTitre: "Nouveautés", favoriteVideoSelected: $favoriteVideoSelected)
                            case "Discussions":
                                ListTopicView(path: $path)
                            case "ProfileView":
                                ProfileView(path: $path, favoriteVideoSelected: $favoriteVideoSelected)
                            default:
                                Text("Vue inconnue")
                            }
                        }
                }
            }
        }
        .onAppear() {
            GlobalViewModel.shared.fetchCategories()
            onboardingViewModel.fetchOnboardingPages()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

