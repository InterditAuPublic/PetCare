//
//  EditAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 31/01/2024.
//

import UIKit

class EditAnimalViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    let editAnimalView = AnimalView()
    var animal: Animal
    
    // MARK: - Initialization
    
    init(animal: Animal) {
        self.animal = animal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = editAnimalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("edit_animal_title", comment: "")
        view.backgroundColor = .white
        let editButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateAnimal))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        editAnimalView.imageView.addGestureRecognizer(tapGesture)
        
        navigationItem.rightBarButtonItem = editButton
        editAnimalView.populate(with: animal)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        
    }
    
    // MARK: - Actions
    
    @objc private func updateAnimal() {
        guard let name = editAnimalView.nameTextField.text, !name.isEmpty else {
            editAnimalView.toggleError(field: editAnimalView.nameTextField, errorMessage: NSLocalizedString("name_error", comment: ""))
            return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal

        guard let weightText = editAnimalView.weightTextField.text, !weightText.isEmpty, let weightNumber = numberFormatter.number(from: weightText) else {
            editAnimalView.toggleError(field: editAnimalView.weightTextField, errorMessage: NSLocalizedString("weight_format_error", comment: ""))
            return
        }
        
        let weight = weightNumber.doubleValue
        
        // Create an AnimalForm object and populate its properties
        let animalForm = AnimalForm(
            id: animal.id,
            identifier: editAnimalView.identifierTextField.text,
            name: name,
            sexe: editAnimalView.sexSegmentedControl.selectedSegmentIndex == 0 ? false : true,
            sterilized: editAnimalView.sterilizedSegmentedControl.selectedSegmentIndex == 0 ? false : true,
            species: Species.allCases[editAnimalView.speciesSegmentedControl.selectedSegmentIndex],
            breed: editAnimalView.breedTextField.text,
            birthdate: editAnimalView.birthdatePicker.date,
            weight: weight,
            color: editAnimalView.colorTextField.text,
            comments: editAnimalView.commentsTextField.text,
            image: editAnimalView.imageView.image?.pngData()
        )
        
        CoreDataManager.shared.updateAnimal(form: animalForm)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func openImagePicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            editAnimalView.imageView.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
