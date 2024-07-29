//
//  ContentView.swift
//  Tip-stop
//
//  Created by Apprenant 122 on 18/07/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var showOnboarding = true

    var body: some View {
        InfiniteScrollView()
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingPageView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
