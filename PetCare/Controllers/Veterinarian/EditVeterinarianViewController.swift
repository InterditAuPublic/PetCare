//
//  EditVeterinarianViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class EditVeterinarianViewController: UIViewController {

    // MARK: - Properties

    let editVeterinarianView = VeterinarianView()
    var veterinarian: Veterinarian

    // MARK: - Initialization

    // Custom initializer to pass the veterinarian object
    init(veterinarian: Veterinarian) {
        self.veterinarian = veterinarian
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    // Load the custom view for this view controller
    override func loadView() {
        view = editVeterinarianView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title for the navigation bar
        title = NSLocalizedString("edit_veterinarian_title", comment: "")
        view.backgroundColor = .white
        
        // Add a save button to the navigation bar
        let editButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateVeterinarian))
        navigationItem.rightBarButtonItem = editButton
        
        // Populate the view with the veterinarian's current data
        editVeterinarianView.populate(with: veterinarian)
    }

    // MARK: - Actions

    // Method to handle the update of the veterinarian
    @objc private func updateVeterinarian() {
        
        // Validate the name field
        guard let name = editVeterinarianView.nameTextField.text, !name.isEmpty else {
            editVeterinarianView.toggleError(field: editVeterinarianView.nameTextField, errorMessage: NSLocalizedString("name_error", comment: ""))
            return
        }
        
        // Validate the address field
        guard let address = editVeterinarianView.addressTextField.text, !address.isEmpty else {
            editVeterinarianView.toggleError(field: editVeterinarianView.addressTextField, errorMessage: NSLocalizedString("address_error", comment: ""))
            return
        }
        
        // Validate the zipcode field
        guard let zipcode = editVeterinarianView.zipcodeTextField.text, !zipcode.isEmpty else {
            editVeterinarianView.toggleError(field: editVeterinarianView.zipcodeTextField, errorMessage: NSLocalizedString("zipcode_error", comment: ""))
            return
        }
        
        // Validate the city field
        guard let city = editVeterinarianView.cityTextField.text, !city.isEmpty else {
            editVeterinarianView.toggleError(field: editVeterinarianView.cityTextField, errorMessage: NSLocalizedString("city_error", comment: ""))
            return
        }
        
        // Create a VeterinarianForm object and populate its properties
        let veterinarianForm = VeterinarianForm(
            id: veterinarian.id, // Use the existing ID to update the correct record
            name: name,
            address: address,
            zipcode: zipcode,
            city: city,
            phone: editVeterinarianView.phoneTextField.text,
            email: editVeterinarianView.emailTextField.text,
            note: editVeterinarianView.noteTextField.text
        )
        
        // Update the veterinarian record in CoreData (or another storage mechanism)
        CoreDataManager.shared.updateVeterinarian(form: veterinarianForm)
        
        // Navigate back to the root view controller
        navigationController?.popToRootViewController(animated: true)
    }
}
