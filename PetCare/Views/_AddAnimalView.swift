//
//  _AddAnimalView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 15/01/2024.
//

import UIKit

class AddAnimalView: UIScrollView {

    var animalForm: AnimalForm?
    var animalDelegate: AddAnimalDelegate?
    
    // MARK: - Properties
    let speciesOptions: [Species] = Species.allSpecies

    init() {
        super.init(frame: .zero)
        animalForm = AnimalForm(animal: Animal())
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let animalForm = animalForm else { return }
        addSubview(animalForm)
        
        // Venter the form in the scroll view
        animalForm.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        // Set up constraints for AnimalForm
        NSLayoutConstraint.activate([
            animalForm.topAnchor.constraint(equalTo: topAnchor),
            animalForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            animalForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            animalForm.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        animalForm.translatesAutoresizingMaskIntoConstraints = false
    }
}

// Set the delegate of the text field to the view controller
extension AddAnimalView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

protocol AddAnimalDelegate {
    func selectedSpecies(name: String, species: Species)
    func nextButtonTapped(with animalInfo: [String: Any])
}



