//
//  AddAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class AddAnimalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties

    let addAnimalView = AnimalView()
    
    
    // MARK: - Lifecycle

    override func loadView() {
        view = addAnimalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("add_animal_title", comment: "")
        view.backgroundColor = .white
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAnimal))
        navigationItem.rightBarButtonItem = addButton
        
        // Add tap gesture to the image view to open the image picker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        addAnimalView.imageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions

    // Func to save the animal
    @objc private func saveAnimal() {
        // Validate name
        guard let name = addAnimalView.nameTextField.text, !name.isEmpty else {
            addAnimalView.toggleError(field: addAnimalView.nameTextField, errorMessage: NSLocalizedString("name_error", comment: ""))
            return
        }

        // Setup number formatter
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal

        // Validate weight
        var weight: Double?
        if let weightText = addAnimalView.weightTextField.text, !weightText.isEmpty {
            guard let weightNumber = numberFormatter.number(from: weightText) else {
                addAnimalView.toggleError(field: addAnimalView.weightTextField, errorMessage: NSLocalizedString("weight_format_error", comment: ""))
                return
            }
            weight = weightNumber.doubleValue
        }

        // Get image
        let image = addAnimalView.imageView.image

        // Create animal form
        let animalForm = AnimalForm(
            identifier: addAnimalView.identifierTextField.text,
            name: name,
            sexe: addAnimalView.sexSegmentedControl.selectedSegmentIndex == 1,
            sterilized: addAnimalView.sterilizedSegmentedControl.selectedSegmentIndex == 1,
            species: Species.allCases[addAnimalView.speciesSegmentedControl.selectedSegmentIndex],
            breed: addAnimalView.breedTextField.text,
            birthdate: addAnimalView.birthdatePicker.date,
            weight: weight,
            color: addAnimalView.colorTextField.text,
            comments: addAnimalView.commentsTextField.text,
            image: image?.pngData()
        )

        // Save animal form
        CoreDataManager.shared.saveAnimal(form: animalForm)

        // Pop view controller
        navigationController?.popViewController(animated: true)
    }
    
    // Func to open the image picker
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
        
        // Set image to the image view of the add animal view if an image is selected
        if let selectedImage = info[.originalImage] as? UIImage {
            addAnimalView.imageView.image = selectedImage
        }
    }
    
    // Dismiss the image picker if the user cancels
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
