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
        
        let HomeViewController = HomeView2Controller()
        let AnimalsViewController = AnimalsViewController()
        let VeterinariansViewController = VeterinariansViewController()
        let AppointementViewController = AppointementViewController()
        let SettingsViewController = SettingsViewController()
        
        HomeViewController.tabBarItem.image = UIImage(systemName: "house")
        AnimalsViewController.tabBarItem.image = UIImage(systemName: "pawprint")
        VeterinariansViewController.tabBarItem.image = UIImage(systemName: "syringe")
        AppointementViewController.tabBarItem.image =  UIImage(systemName: "calendar")
        SettingsViewController.tabBarItem.image = UIImage(systemName: "gearshape")
        
        HomeViewController.title = NSLocalizedString("petcare", comment: "")
        AnimalsViewController.title = NSLocalizedString("animals", comment: "")
        VeterinariansViewController.title = NSLocalizedString("vet", comment: "")
        AppointementViewController.title = NSLocalizedString("my_appointments", comment: "")
        AppointementViewController.tabBarItem.title = NSLocalizedString("appointments", comment: "")
        SettingsViewController.title = NSLocalizedString("settings", comment: "")
        
        let HomeNavigation = UINavigationController(rootViewController: HomeViewController)
        let AnimalsNavigation = UINavigationController(rootViewController: AnimalsViewController)
        let VeterinariansNavigation = UINavigationController(rootViewController: VeterinariansViewController)
        let AppointementsNavigation = UINavigationController(rootViewController: AppointementViewController)
        let SettingsNavigation = UINavigationController(rootViewController: SettingsViewController)
        
        setViewControllers([HomeNavigation, AnimalsNavigation, VeterinariansNavigation, AppointementsNavigation, SettingsNavigation], animated: true)
    }
    
    private func configureUI(){
        self.tabBar.isTranslucent = false
//        self.tabBar.tintColor = .orange
        self.tabBar.backgroundColor = .white
        self.tabBar.unselectedItemTintColor = .gray
    }
}
