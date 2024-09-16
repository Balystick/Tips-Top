//
//  OnboardingPageView.swift
//  Tip-stop
//
//  Created by Aurélien on 29/07/2024.
//

import SwiftUI
import UIKit

struct OnboardingPageView: UIViewControllerRepresentable {
    let onboardingPages: [OnboardingPage]
    typealias UIViewControllerType = OnboardingViewController
    
    func makeUIViewController(context: Context) -> OnboardingViewController {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        viewController.onboardingPages = onboardingPages
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: OnboardingViewController, context: Context) {
        // No update needed for now
    }
}
