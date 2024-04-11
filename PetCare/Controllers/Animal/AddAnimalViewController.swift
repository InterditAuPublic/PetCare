//
//  AddAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class AddAnimalViewController: UIViewController, UIGestureRecognizerDelegate, AddAnimalDelegate, FormDelegate {
    
    
    // MARK: - Properties
    var animalToSave = Animal()
    let addAnimalView = AddAnimalView()
//    let speciesOptions: [Species] = Species.allSpecies
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func configureNavigationBar() {
//        navigationController?.navigationBar.tintColor = .orange
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

        self.animalToSave.image = formFields[0].value as? String

        // save the animal to the database
        CoreDataManager.shared.saveAnimal(animal: self.animalToSave)
    }
    
    func selectedSpecies(name: String, species: Species) {
        print("Selected species: \(name) - \(species)")
    }
    
    func nextButtonTapped(with animalInfo: [String : Any]) {
        print("next")
    }

    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        switch field {
        case let textField as TextFormField:
            switch textField.labelText {
            case NSLocalizedString("identifier", comment: ""):
                self.animalToSave.identifier = value as? String
            case NSLocalizedString("name", comment: ""):
                self.animalToSave.name = value as? String
            case NSLocalizedString("breed", comment: ""):
                self.animalToSave.breed = value as? String
            case NSLocalizedString("weight", comment: ""):
                self.animalToSave.weight = value as? String
            case NSLocalizedString("color", comment: ""):
                self.animalToSave.color = value as? String
            case NSLocalizedString("comments", comment: ""):
                self.animalToSave.comments = value as? String
            default:
                break
            }
        case let pickerField as PickerFormField:
            if pickerField.labelText == NSLocalizedString("species", comment: "") {
                self.animalToSave.species = value as? Species
            }
        case let dateField as DateFormField:
            if dateField.labelText == NSLocalizedString("birthdate", comment: "") {
                self.animalToSave.birthdate = value as? Date
            }
        case let segmentField as SegmentFormField:
            if segmentField.labelText == NSLocalizedString("sex", comment: "") {
                self.animalToSave.sexe = (value as! String) == "Female" ? false : true
            }
        default:
            break
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
