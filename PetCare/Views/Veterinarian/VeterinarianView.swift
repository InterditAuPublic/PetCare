//
//  AddVeterinarianView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/01/2024.
//

import UIKit
import DTTextField

class VeterinarianView: UIScrollView {
    
    // MARK: - Properties
    
    // Text fields for veterinarian information
    let nameTextField: DTTextField = createDTTextField(placeholder: NSLocalizedString("veterinarian_name_placeholder", comment: ""))
    let addressTextField: DTTextField = createDTTextField(placeholder: NSLocalizedString("veterinarian_adresse_placeholder", comment: ""))
    let zipcodeTextField: DTTextField = createDTTextField(placeholder: NSLocalizedString("veterinarian_zipcode_placeholder", comment: ""))
    let cityTextField: DTTextField = createDTTextField(placeholder: NSLocalizedString("veterinarian_city_placeholder", comment: ""))
    let phoneTextField: DTTextField = createDTTextField(placeholder: NSLocalizedString("veterinarian_phone_placeholder", comment: ""))
    let emailTextField: DTTextField = createDTTextField(placeholder: NSLocalizedString("veterinarian_email_placeholder", comment: ""))
    let noteTextField: DTTextField = createDTTextField(placeholder: NSLocalizedString("veterinarian_note_placeholder", comment: ""))
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    // Populate the text fields with veterinarian information
    func populate(with veterinarian: Veterinarian) {
        nameTextField.text = veterinarian.name
        addressTextField.text = veterinarian.address
        zipcodeTextField.text = veterinarian.zipcode
        cityTextField.text = veterinarian.city
        phoneTextField.text = veterinarian.phone
        emailTextField.text = veterinarian.email
        noteTextField.text = veterinarian.note
    }
    
    // Display an error message below the text field
    func toggleError(field: DTTextField, errorMessage: String ) {
        field.errorMessage = errorMessage
        field.showError()
        scrollRectToVisible(field.frame, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        // Create a container view to hold the text fields
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        // Create a stack view to arrange the text fields vertically
        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
            addressTextField,
            zipcodeTextField,
            cityTextField,
            phoneTextField,
            emailTextField,
            noteTextField
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        // Ensure text fields and other controls stretch horizontally
        [nameTextField, addressTextField, zipcodeTextField, cityTextField, phoneTextField, emailTextField, noteTextField].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
    }
    
    private func resetFieldBorders() {
        // Reset the border color of the text fields
        [nameTextField, addressTextField, zipcodeTextField, cityTextField, phoneTextField, emailTextField, noteTextField].forEach {
            $0.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    // MARK: - Utility Methods
    
    // Create a label with specified text
    private static func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
    
    // Create a DTTextField with specified placeholder
    private static func createDTTextField(placeholder: String) -> DTTextField {
        let textField = DTTextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .orange
        textField.placeholder = placeholder
        return textField
    }
}
