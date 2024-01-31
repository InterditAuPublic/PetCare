//
//  EditAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 31/01/2024.
//

import UIKit

class EditAnimalViewController: UIViewController {

    var editAnimalView: EditAnimalView?
    var animal: Animal?
    
    init(animal: Animal) {
        self.animal = animal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = animal?.name
        navigationItem.largeTitleDisplayMode = .never
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        editAnimalView = EditAnimalView(animal: animal)
        guard let editAnimalView = editAnimalView else { return }
        
        view.addSubview(editAnimalView)
        editAnimalView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editAnimalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editAnimalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editAnimalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editAnimalView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        editAnimalView.animalForm?.delegate = self
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    @objc private func saveButtonTapped() {
        guard let animalForm = editAnimalView?.animalForm else { return }
        let formFields = animalForm.getFormFields()
        
        guard let name = formFields[2].value as? String, !name.isEmpty else {
            //            showAlert(message: "Vous devez entrer un nom pour votre animal")
            return
        }
        
        // Validate species
        guard let speciesRawValue = formFields[3].value as? String,
              let specie = Species(rawValue: speciesRawValue) else { // TODO: If not changed unable to save the changes
            //            showAlert(message: "Vous devez sélectionner une espèce pour votre animal")
            return
        }
        
        var animal = Animal()
        animal.id = self.animal?.id
        animal.image = formFields[0].value as? String
        animal.identifier = formFields[1].value as? String
        animal.sexe = formFields[4].value as? Bool
        animal.breed = formFields[5].value as? String
        animal.birthdate = formFields[6].value as? Date
        animal.weight = formFields[7].value as? String
        animal.color = formFields[8].value as? String
        animal.comments = formFields[9].value as? String
        animal.name = name
        animal.species = specie
        
        // save the animal to the database
        CoreDataManager.shared.updateAnimal(animal: animal)
        
        navigationController?.popViewController(animated: true)
    }
}

extension EditAnimalViewController: FormDelegate {
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
    }
}
