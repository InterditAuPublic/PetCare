//
//  AddVeterinarianViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/01/2024.
//

import UIKit

class AddVeterinarianViewController: UIViewController {
    
    let veterinarianView = VeterinarianView()
    
    // Load the custom view for this view controller
    override func loadView() {
        view = veterinarianView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title for the navigation bar
        title = NSLocalizedString("add_veterinarian_title", comment: "")
        view.backgroundColor = .white

        // Add a save button to the navigation bar
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveVeterinarian))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveVeterinarian() {
        
        // Validate the name field
        guard let name = veterinarianView.nameTextField.text, !name.isEmpty else {
            veterinarianView.toggleError(field: veterinarianView.nameTextField, errorMessage: NSLocalizedString("name_error", comment: ""))
            return
        }
        
        // Validate the address field
        guard let address = veterinarianView.addressTextField.text, !address.isEmpty else {
            veterinarianView.toggleError(field: veterinarianView.addressTextField, errorMessage: NSLocalizedString("address_error", comment: ""))
            return
        }
        
        // Validate the zipcode field
        guard let zipcode = veterinarianView.zipcodeTextField.text, !zipcode.isEmpty else {
            veterinarianView.toggleError(field: veterinarianView.zipcodeTextField, errorMessage: NSLocalizedString("zipcode_error", comment: ""))
            return
        }
        
        // Validate the city field
        guard let city = veterinarianView.cityTextField.text, !city.isEmpty else {
            veterinarianView.toggleError(field: veterinarianView.cityTextField, errorMessage: NSLocalizedString("city_error", comment: ""))
            return
        }
        
        // Create a VeterinarianForm object and populate its properties
        let veterinarianForm = VeterinarianForm(
            name: name,
            address: address,
            zipcode: zipcode,
            city: city,
            phone: veterinarianView.phoneTextField.text,
            email: veterinarianView.emailTextField.text,
            note: veterinarianView.noteTextField.text
        )
        
        // Save the new veterinarian to CoreData (or any other storage mechanism)
        CoreDataManager.shared.saveVeterinarian(form: veterinarianForm)
        
        // Navigate back to the previous view controller
        navigationController?.popViewController(animated: true)
    }
}
