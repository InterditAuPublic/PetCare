//
//  LoadingView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit
import Lottie

class LoadingView: UIViewController {

    private var _animationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimationView()
        animate()
    }

    private func configureAnimationView() {
        _animationView = AnimationView(name: "loadingCat")
        guard let animationView = _animationView else { return }
        
        let animationSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.5)
        let animationFrame = CGRect(
            origin: CGPoint(x: (view.bounds.width - animationSize.width) / 2, y: (view.bounds.height - animationSize.height) / 2),
            size: animationSize
        )
        animationView.frame = animationFrame
        
        animationView.loopMode = .loop
        animationView.animationSpeed = 10
        
        view.addSubview(animationView)
    }

    private func animate() {
        guard let animationView = _animationView else { return }
        animationView.play()
    }
}

