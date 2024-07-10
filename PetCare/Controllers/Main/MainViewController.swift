//
//  MainViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private var animationView: LoadingView?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAndShowAnimationView()
    }
    
    // Configure and show the animation view
    private func configureAndShowAnimationView() {
        guard animationView == nil else { return }
        animationView = LoadingView()
        animationView?.modalPresentationStyle = .fullScreen
        present(animationView!, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hideAnimationViewAndLoadMainView()
            }
        }
    }

    // Dismiss the animation view and load the main view
    private func hideAnimationViewAndLoadMainView() {
        animationView?.dismiss(animated: true) {
            self.animationView = nil
            let navigationController = TabBarController()
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        }
    }
}
