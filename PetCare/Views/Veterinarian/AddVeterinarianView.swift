//
//  AddVeterinarianView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/01/2024.
//

import UIKit

class AddVeterinarianView: UIScrollView, UITextFieldDelegate {

    var VetForm = VeterinarianForm(veterinarian: Veterinarian())

    // MARK: - Properties
    let speciesOptions: [Species] = Species.allSpecies

    init() {
        super.init(frame: .zero)
//        VetForm = VeterinarianForm(veterinarian: Veterinarian())
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(VetForm)
        
        // Center the form in the scroll view
        VetForm.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        // Set up constraints for AnimalForm
        NSLayoutConstraint.activate([
            VetForm.topAnchor.constraint(equalTo: topAnchor),
            VetForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            VetForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            VetForm.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        VetForm.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
