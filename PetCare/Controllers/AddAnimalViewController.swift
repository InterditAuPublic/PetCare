//
//  AddAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class AddAnimalViewController: UIViewController, AddAnimalDelegate
{
    func selectedSpecies(name: String, species: Species) {
        print("Selected species: \(name) - \(species)")
    }
    
    func nextButtonTapped(with animalInfo: [String: Any]) {
        print("Received animal information: \(animalInfo)")
    }
    
    let addAnimalView = AddAnimalView()
    
    let speciesOptions: [Species] = Species.allSpecies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        navigationController?.navigationBar.tintColor = .orange
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(addAnimalView)
        addAnimalView.animalDelegate = self
        addAnimalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addAnimalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addAnimalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addAnimalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addAnimalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

