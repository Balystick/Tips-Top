//
//  OnboardingViewModel.swift
//  Tip-stop
//
//  Created by Aurélien on 12/09/2024.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var onboardingPages: [OnboardingPage] = []
    
    func fetchOnboardingPages() {
        guard let url = URL(string: GlobalViewModel.shared.baseURL + "onboardingPages") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedOnboardingPages = try JSONDecoder().decode([OnboardingPage].self, from: data)
                    DispatchQueue.main.async {
                        self.onboardingPages = decodedOnboardingPages
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
}
