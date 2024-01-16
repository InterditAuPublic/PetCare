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

//extension AddAnimalView: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return speciesOptions[row].rawValue
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        let selectedSpecies = speciesOptions[row]
//        animalDelegate?.selectedSpecies(name: selectedSpecies.rawValue, species: selectedSpecies)
//    }
//}
//
//extension AddAnimalView: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return speciesOptions.count
//    }
//}

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



