//
//  OnboardingViewController.swift
//  Tip-stop
//
//  Created by Aurélien on 29/07/2024.
//
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages: [UIViewController] = []
    
    let pageData = [
        ["imageName": "welcome_image", "text": "Bienvenue dans Tips Top !", "buttonText": "Suivant"],
        ["imageName": "suggestions_image", "text": "Découvrez des astuces personnalisées", "buttonText": "Suivant"],
        ["imageName": "search_image", "text": "Recherchez des fonctionnalités", "buttonText": "Suivant"],
        ["imageName": "profile_image", "text": "Gérez vos favoris", "buttonText": "Suivant"],
        ["imageName": "forum_image", "text": "Participez aux discussions", "buttonText": "Suivant"],
        ["imageName": "start_image", "text": "Prêt à commencer?", "buttonText": "Commencer"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        
        for (index, page) in pageData.enumerated() {
            if let pageVC = storyboard.instantiateViewController(withIdentifier: "OnboardingPageViewController") as? OnboardingPageViewController {
                pageVC.imageName = page["imageName"]
                pageVC.text = page["text"]
                pageVC.buttonText = page["buttonText"]
                pageVC.isLastPage = (index == pageData.count - 1)
                pages.append(pageVC)
            }
        }
        
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        return previousIndex >= 0 ? pages[previousIndex] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        return nextIndex < pages.count ? pages[nextIndex] : nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentVC = viewControllers?.first, let currentIndex = pages.firstIndex(of: currentVC) else { return 0 }
        return currentIndex
    }
}
