//
//  TabBarController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItems()
        configureUI()
    }
    
    
    private func configureTabBarItems() {
        
        let HomeViewController = HomeViewController()
        let AnimalsViewController = AnimalsViewController()
        let VeterinariansViewController = VeterinariansViewController()
        let AppointementViewController = AppointmentsViewController()
        
        HomeViewController.tabBarItem.image = UIImage(systemName: "house")
        AnimalsViewController.tabBarItem.image = UIImage(systemName: "pawprint")
        VeterinariansViewController.tabBarItem.image = UIImage(systemName: "syringe")
        AppointementViewController.tabBarItem.image =  UIImage(systemName: "calendar")
        
        HomeViewController.title = NSLocalizedString("petcare", comment: "")
        AnimalsViewController.title = NSLocalizedString("animals", comment: "")
        VeterinariansViewController.title = NSLocalizedString("vet", comment: "")
        AppointementViewController.title = NSLocalizedString("my_appointments", comment: "")
        AppointementViewController.tabBarItem.title = NSLocalizedString("appointments", comment: "")
        
        let HomeNavigation = UINavigationController(rootViewController: HomeViewController)
        let AnimalsNavigation = UINavigationController(rootViewController: AnimalsViewController)
        let VeterinariansNavigation = UINavigationController(rootViewController: VeterinariansViewController)
        let AppointementsNavigation = UINavigationController(rootViewController: AppointementViewController)
        
        setViewControllers([HomeNavigation, AnimalsNavigation, VeterinariansNavigation, AppointementsNavigation], animated: true)
    }
    
    private func configureUI(){
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.unselectedItemTintColor = .gray
    }
}
