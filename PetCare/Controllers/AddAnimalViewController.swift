//
//  AddAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//
import UIKit

class AddAnimalViewController: UIViewController, AddAnimalDelegate, FormDelegate {
    func nextButtonTapped(with animalInfo: [String : Any]) {
        print("next")
    }
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        
        
    }
    
    
    // MARK: - Properties
    var animalToSave: Animal?
    let addAnimalView = AddAnimalView()
    let speciesOptions: [Species] = Species.allSpecies
    //    let sexeOptions: [Sexe] = Sexe.allSexe
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
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
        
        // print the form values to the console and the form index
        
        for field in formFields {
            
            print("Field: \(field.labelText ?? "") - Value: \(field.value ?? "")")
            
        }
        
        
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
        //
        //        guard let breed = formFields[4].value as? String else {
        //        showAlert(message: "La RACE est obligatoire")
        //            return
        //        }
        
        var animal = Animal()
        animal.image = formFields[0].value as? String
        animal.identifier = formFields[1].value as? String
        animal.sexe = formFields[4].value as? Int64
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
    
    //    func nextButtonTapped(with animalInfo: [String: Any]) {
    //        print("Received animal information: \(animalInfo)")
    //
    //        // Validate name
    //        guard let name = animalInfo["name"] as? String, !name.isEmpty else {
    //            showAlert(message: "Vous devez entrer un nom pour votre animal")
    //            return
    //        }
    //
    //        // Validate species
    //        guard let speciesRawValue = animalInfo["species"] as? String,
    //              let species = Species(rawValue: speciesRawValue) else {
    //            showAlert(message: "Vous devez sélectionner une espèce pour votre animal")
    //            return
    //        }
    //
    //        //        guard let sexeRawValue = animalInfo["sexe"] as? String,
    //        //              let sexe = Sexe(rawValue: sexeRawValue) else {
    //        //            showAlert(message: "oee")
    //        //            return
    //        //        }
    //
    //        // Create Animal instance
    //        animalToSave = Animal(
    //            identifier: animalInfo["identifier"] as? String,
    //            name: name,
    //            sexe: animalInfo["sexe"] as? Int64,
    //            species: species,
    //            breed: animalInfo["breed"] as? String,
    //            birthdate: animalInfo["birthdate"] as? Date,
    //            weight: animalInfo["weight"] as? String,
    //            color: animalInfo["color"] as? String,
    //            comments: animalInfo["comments"] as? String
    //            //            image: animalInfo["image"] as? String // Realm convert Image as NSData
    //        )
    //
    //        // TODO: Save the animal (uncomment the code when CoreDataManager is implemented)
    //        if let animalToSave = animalToSave {
    //            saveAnimalToCoreData(animalToSave)
    //        } else {
    //            showAlert(message: "Error creating Animal instance")
    //        }
    //    }
    
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
