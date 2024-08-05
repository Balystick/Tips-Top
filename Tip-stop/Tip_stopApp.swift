//
//  Tip_stopApp.swift
//  Tip-stop
//
//  Modified by Aurélien on 18/07/2024.
//

import SwiftUI

@main
struct Tip_stopApp: App {
    init() {
//         Supprime la clé hasSeenOnboarding du UserDefault afin de relancer l'onboarding pour les tests
         UserDefaults.standard.removeObject(forKey: "hasSeenOnboarding")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
