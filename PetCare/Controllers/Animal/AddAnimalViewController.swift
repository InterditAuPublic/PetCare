//
//  AddAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class AddAnimalViewController: UIViewController, UIGestureRecognizerDelegate, AddAnimalDelegate, FormDelegate {
    
    
    // MARK: - Properties
    var animalToSave: Animal?
    let addAnimalView = AddAnimalView()
    let speciesOptions: [Species] = Species.allSpecies
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        configureNavigationBar()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .orange
    }
    
    private func setupUI() {
        setupAddAnimalView()
    }
    
    private func setupAddAnimalView() {
        view.addSubview(addAnimalView)
        addAnimalView.animalDelegate = self
        addAnimalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addAnimalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addAnimalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addAnimalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addAnimalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        addAnimalView.animalForm?.delegate = self
        
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveButtonTapped() {
        guard let animalForm = addAnimalView.animalForm else { return }
        
        let formFields = animalForm.getFormFields()
        
        guard let name = formFields[2].value as? String, !name.isEmpty else {
            showAlert(message: "Vous devez entrer un nom pour votre animal")
            return
        }
        
        // Validate species
        guard let speciesRawValue = formFields[3].value as? String,
              let species = Species(rawValue: speciesRawValue) else {
            showAlert(message: "Vous devez sélectionner une espèce pour votre animal")
            return
        }
        
        var animal = Animal()
        animal.image = formFields[0].value as? String
        animal.identifier = formFields[1].value as? String
        animal.sexe = formFields[4].value as? Bool
        animal.breed = formFields[5].value as? String
        animal.birthdate = formFields[6].value as? Date
        animal.weight = formFields[7].value as? String
        animal.color = formFields[8].value as? String
        animal.comments = formFields[9].value as? String
        animal.name = name
        animal.species = species
        
        // save the animal to the database
        CoreDataManager.shared.saveAnimal(animal: animal)
    }
    
    func selectedSpecies(name: String, species: Species) {
        print("Selected species: \(name) - \(species)")
    }
    
    func nextButtonTapped(with animalInfo: [String : Any]) {
        print("next")
    }
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        
    }
    
    // MARK: - Helper Methods
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Attention", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // TODO:  implement this method when CoreDataManager is implemented
    private func saveAnimalToCoreData(_ animal: Animal) {
        
        CoreDataManager.shared.saveAnimal(animal: animal)
        print("Animal saved to Core Data")
    }
}
