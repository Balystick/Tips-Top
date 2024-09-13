//
//  Onboarding.swift
//  Tip-stop
//
//  Created by Aurélien on 12/09/2024.
//

import Foundation

struct OnboardingPage: Codable, Identifiable {
    let id: UUID
    let videoName: String
    let titleText: String
    let text: String
}
