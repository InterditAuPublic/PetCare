//
//  ViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 05/01/2024.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    var animationView: AnimationView?


    override func viewDidLoad() {

      super.viewDidLoad()
      
     animate()
    }

    func animate() {
    animationView = AnimationView(name: "loadingCat")
    
    // Définir la taille du cadre de l'animation
    let animationSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.5)
    
    animationView!.frame = CGRect(origin: CGPoint(x: (view.bounds.width - animationSize.width) / 2, y: (view.bounds.height - animationSize.height) / 2), size: animationSize)
    
    animationView!.loopMode = .loop
        animationView!.animationSpeed = 1.5
    view.addSubview(animationView!)
    animationView!.play()
}

}

