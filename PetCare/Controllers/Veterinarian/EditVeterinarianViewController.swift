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

    init(veterinarian: Veterinarian) {
        self.veterinarian = veterinarian
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func loadView() {
        view = editVeterinarianView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("edit_veterinarian_title", comment: "")
        view.backgroundColor = .white
        let editButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateVeterinarian))
        navigationItem.rightBarButtonItem = editButton
        editVeterinarianView.populate(with: veterinarian)
    }

    // MARK: - Actions

    @objc private func updateVeterinarian() {
        guard let name = editVeterinarianView.nameTextField.text, !name.isEmpty else {
            editVeterinarianView.toggleError(field: editVeterinarianView.nameTextField, errorMessage: NSLocalizedString("name_error", comment: ""))
            return
        }
        
        guard let address = editVeterinarianView.addressTextField.text, !address.isEmpty else {
            editVeterinarianView.toggleError(field: editVeterinarianView.addressTextField, errorMessage: NSLocalizedString("address_error", comment: ""))
            return
        }
        
        guard let zipcode = editVeterinarianView.zipcodeTextField.text, !zipcode.isEmpty else {
            editVeterinarianView.toggleError(field: editVeterinarianView.zipcodeTextField, errorMessage: NSLocalizedString("zipcode_error", comment: ""))
            return
        }
        
        guard let city = editVeterinarianView.cityTextField.text, !city.isEmpty else {
            editVeterinarianView.toggleError(field: editVeterinarianView.cityTextField, errorMessage: NSLocalizedString("city_error", comment: ""))
            return
        }
        
        // Create an VeterinarianForm object and populate its properties
        let veterinarianForm = VeterinarianForm(
            id: veterinarian.id,
            name: name,
            address: address,
            zipcode: zipcode,
            city: city,
            phone: editVeterinarianView.phoneTextField.text,
            email: editVeterinarianView.emailTextField.text,
            note: editVeterinarianView.noteTextField.text
            
        )
        
        CoreDataManager.shared.updateVeterinarian(form: veterinarianForm)
        
        navigationController?.popToRootViewController(animated: true)
    }
}

