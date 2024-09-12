//
//  OnboardingViewController.swift
//  Tip-stop
//
//  Created par Aurélien le 29/07/2024.
//

import UIKit

/// Un `UIPageViewController` pour l'onboarding de l'app.
/// - L'utilisateur peut faire défiler plusieurs pages contenant des vidéos et des descriptions
/// - Lorsque l'utilisateur a atteint la dernière page, l'onboarding se termine automatiquement après 3 secondes
class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var onboardingPages: [OnboardingPage]?
    
    var pages: [UIViewController] = []
    
    var isOnLastPage = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        
        guard let onboardingPages = onboardingPages else { return }
                
        for page in onboardingPages {
            if let pageVC = storyboard.instantiateViewController(withIdentifier: "OnboardingPageViewController") as? OnboardingPageViewController {
                if let videoURL = URL(string: GlobalViewModel.shared.baseVideoURL + page.videoName) {
                    pageVC.videoURL = videoURL
                }
                pageVC.titleText = page.titleText
                pageVC.descriptionText = page.text
                pages.append(pageVC)
            }
        }
        
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        configurePageControl()
    }

    private func configurePageControl() {
        let pageControlAppearance = UIPageControl.appearance(whenContainedInInstancesOf: [OnboardingViewController.self])
        pageControlAppearance.pageIndicatorTintColor = UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.lightGray : UIColor(white: 0.7, alpha: 1.0)
        }
        pageControlAppearance.currentPageIndicatorTintColor = UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor(white: 0.2, alpha: 1.0)
        }
        pageControlAppearance.backgroundColor = UIColor.clear
    }
    
    // Retourne le view controller qui précède le view controller actuel
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        return previousIndex >= 0 ? pages[previousIndex] : nil
    }
    
    // Retourne le view controller qui suit le view controller actuel
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        return nextIndex < pages.count ? pages[nextIndex] : nil
    }
    
    // Appelée avant la transition vers un nouveau view controller pour vérifier si l'utilisateur est sur la dernière page de l'onbaording
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let viewController = pendingViewControllers.first else { return }
        if let currentIndex = pages.firstIndex(of: viewController), currentIndex == pages.count - 1 {
            isOnLastPage = true
        } else {
            isOnLastPage = false
        }
    }
    
    // Appelée après la transition vers un nouveau view controller et appelle completeOnboarding après 1.5 secondes si l'utilisateur est sur la dernière page de l'onboarding
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed && isOnLastPage {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.completeOnboarding()
            }
        }
    }
    
    // Retourne le nombre de pages dans le page view controller
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    // Retourne l'index de la page actuelle dans le page view controller
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentVC = viewControllers?.first, let currentIndex = pages.firstIndex(of: currentVC) else { return 0 }
        return currentIndex
    }
    
    // Termine l'onboarding, met à jour le userdefaults et ferme le view controller
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        self.dismiss(animated: true, completion: nil)
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
