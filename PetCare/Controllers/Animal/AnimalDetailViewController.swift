//
//  AnimalDetailViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 11/01/2024.
//


import UIKit

class AnimalDetailViewController: UIViewController {
    
    var animalDetailView: AnimalDetailView?
    var selectedAnimal: Animal?
    
    init(selectedAnimal: Animal) {
        self.selectedAnimal = selectedAnimal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        animalDetailView = AnimalDetailView(animal: selectedAnimal)
        guard let animalDetailView = animalDetailView else { return }
        
        view.addSubview(animalDetailView)
        animalDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animalDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animalDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animalDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animalDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        animalDetailView.animalForm?.delegate = self
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }
    
    
    @objc private func editButtonTapped() {
        // navigate to the edit view controller
        guard let selectedAnimal = selectedAnimal else { return }
        let editAnimalViewController = EditAnimalViewController(animal: selectedAnimal)
        navigationController?.pushViewController(editAnimalViewController, animated: true)

    }

    
}

extension AnimalDetailViewController: FormDelegate {
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        // change the value of the animal 
        print("In update")
        // update the animal in the database
    }
}
