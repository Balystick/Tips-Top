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

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.white // Force le fullscreen de la zone d'affichage
                    .ignoresSafeArea()
                if !hasSeenOnboarding {
                    OnboardingPageView()
                } else {
                    InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "", hasSeenOnboarding: $hasSeenOnboarding)
                        .navigationDestination(for: String.self) { value in
                            switch value {
                            case "DecouverteView":
                                DecouverteView(path: $path, globalDataModel: globalDataModel)
                            case "InfiniteScrollView:Productivité":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Productivité", hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Personnalisation":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Personnalisation", hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Utilisation Avancée":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Utilisation Avancée", hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Sécurité & Confidentialité":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Sécurité & Confidentialité", hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Connectivité et Communication":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Connectivité et Communication", hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Multimédia":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Multimédia", hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Accessibilité":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Accessibilité", hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Batterie et Performances":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Batterie et Performances", hasSeenOnboarding: $hasSeenOnboarding)
                            case "InfiniteScrollView:Nouveautés":
                                InfiniteScrollView(path: $path, globalDataModel: globalDataModel, categoryTitre: "Nouveautés", hasSeenOnboarding: $hasSeenOnboarding)
                            case "Discussions":
                                ListTopicView(path: $path, globalDataModel: globalDataModel)
                            case "ProfileView":
                                ProfileView(path: $path, globalDataModel: globalDataModel)
                                //                      case "StepsView":
                                //                        StepsView(path: $path, globalDataModel: globalDataModel)
                                //                      case "CommentsView":
                                //                        CommentsView(path: $path, globalDataModel: globalDataModel)
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

