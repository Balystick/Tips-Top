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
                        case "ProfileView":
                            ProfileView(path: $path, globalDataModel: globalDataModel)
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
