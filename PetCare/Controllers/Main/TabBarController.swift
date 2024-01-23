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
        let VetAppointementViewController = VetAppointmentViewController()
        let SettingsViewController = SettingsViewController()
        
        HomeViewController.tabBarItem.image = UIImage(systemName: "house")
        AnimalsViewController.tabBarItem.image = UIImage(systemName: "pawprint")
        VetAppointementViewController.tabBarItem.image = UIImage(systemName: "syringe")
        SettingsViewController.tabBarItem.image = UIImage(systemName: "gearshape")
        
        HomeViewController.tabBarItem.title = "Home"
        HomeViewController.title = "PetCare"
        AnimalsViewController.title = "Animals"
        VetAppointementViewController.title = "Vet Appointement"
        SettingsViewController.title = "Settings"
        
        let HomeNavigation = UINavigationController(rootViewController: HomeViewController)
        let AnimalsNavigation = UINavigationController(rootViewController: AnimalsViewController)
        let VetAppointementNavigation = UINavigationController(rootViewController: VetAppointementViewController)
        let SettingsNavigation = UINavigationController(rootViewController: SettingsViewController)
        
        setViewControllers([HomeNavigation, AnimalsNavigation, VetAppointementNavigation, SettingsNavigation], animated: true)
    }
    
    private func configureUI(){
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .orange
        self.tabBar.backgroundColor = .white
        self.tabBar.unselectedItemTintColor = .gray
    }
}
