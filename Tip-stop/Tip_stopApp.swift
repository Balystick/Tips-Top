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
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(InfiniteScrollViewModel())
        }
    }
}
