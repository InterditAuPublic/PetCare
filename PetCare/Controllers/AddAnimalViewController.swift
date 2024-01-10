//
//  AddAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//
import UIKit

class AddAnimalViewController: UIViewController, AddAnimalDelegate {
    
    // MARK: - Properties
    var animalToSave: Animal?
    let addAnimalView = AddAnimalView()
    let speciesOptions: [Species] = Species.allSpecies
//    let sexeOptions: [Sexe] = Sexe.allSexe
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        navigationController?.navigationBar.tintColor = .orange
    }
    
    private func setupUI() {
        view.backgroundColor = .white
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
    }
    
    // MARK: - AddAnimalDelegate
    
    func selectedSpecies(name: String, species: Species) {
        print("Selected species: \(name) - \(species)")
    }
    
    func nextButtonTapped(with animalInfo: [String: Any]) {
        print("Received animal information: \(animalInfo)")

        // Validate name
        guard let name = animalInfo["name"] as? String, !name.isEmpty else {
            showAlert(message: "Vous devez entrer un nom pour votre animal")
            return
        }

        // Validate species
        guard let speciesRawValue = animalInfo["species"] as? String,
              let species = Species(rawValue: speciesRawValue) else {
            showAlert(message: "Vous devez sélectionner une espèce pour votre animal")
            return
        }
        
//        guard let sexeRawValue = animalInfo["sexe"] as? String,
//              let sexe = Sexe(rawValue: sexeRawValue) else {
//            showAlert(message: "oee")
//            return
//        }

        // Create Animal instance
        animalToSave = Animal(
            identifier: animalInfo["identifier"] as? String,
            name: name,
            sexe: animalInfo["sexe"] as? String,
            species: species,
            breed: animalInfo["breed"] as? String,
            birthdate: animalInfo["birthdate"] as? Date,
            weight: animalInfo["weight"] as? String,
            color: animalInfo["color"] as? String,
            comments: animalInfo["comments"] as? String
//            image: animalInfo["image"] as? String // Realm convert Image as NSData
        )

        // TODO: Save the animal (uncomment the code when CoreDataManager is implemented)
        if let animalToSave = animalToSave {
                    saveAnimalToCoreData(animalToSave)
                } else {
                    showAlert(message: "Error creating Animal instance")
                }
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
