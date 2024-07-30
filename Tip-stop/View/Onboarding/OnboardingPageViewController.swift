//
//  OnboardingPageViewController.swift
//  Tip-stop
//
//  Created by Aurélien on 29/07/2024.
//

import UIKit

class OnboardingPageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var ignoreButton: UIButton!
    
    var imageName: String?
    var text: String?
    var buttonText: String?
    var isLastPage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: imageName ?? "")
        label.text = text
        nextButton.setTitle(buttonText, for: .normal)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if isLastPage {
              (parent as? OnboardingViewController)?.completeOnboarding()
          } else {
              if let onboardingVC = parent as? UIPageViewController {
                  guard let currentIndex = (onboardingVC as? OnboardingViewController)?.pages.firstIndex(of: self) else { return }
                  let nextIndex = currentIndex + 1
                  if nextIndex < (onboardingVC as? OnboardingViewController)?.pages.count ?? 0 {
                      (onboardingVC as? OnboardingViewController)?.setViewControllers([(onboardingVC as? OnboardingViewController)?.pages[nextIndex] ?? UIViewController()], direction: .forward, animated: true, completion: nil)
                  } else {
                      onboardingVC.dismiss(animated: true, completion: nil)
                  }
              }
          }
      }
      
      @IBAction func ignoreButtonTapped(_ sender: UIButton) {
          (parent as? OnboardingViewController)?.completeOnboarding()
      }
  }
