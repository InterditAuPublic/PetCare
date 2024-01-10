//
//  LoadingView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit
import Lottie

class LoadingView: UIViewController {
    
    private var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureAnimationView()
        animate()
    }
    
    private func configureAnimationView() {
        animationView = AnimationView(name: "loadingCat")
        guard let animationView = animationView else { return }
        
        let animationSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.5)
        let animationFrame = CGRect(
            origin: CGPoint(x: (view.bounds.width - animationSize.width) / 2, y: (view.bounds.height - animationSize.height) / 2),
            size: animationSize
        )
        animationView.frame = animationFrame
        animationView.backgroundColor = .white
        
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        
        view.addSubview(animationView)
    }
    
    private func animate() {
        guard let animationView = animationView else { return }
        animationView.play()
    }
    
    private func stopAnimation() {
        guard let animationView = animationView else { return }
        animationView.stop()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
}
