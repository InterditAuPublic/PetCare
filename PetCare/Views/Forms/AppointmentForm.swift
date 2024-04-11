//
//  AppointmentForm.swift
//  PetCare
//
//  Created by Melvin Poutrel on 17/03/2024.
//

import UIKit

class AppointmentForm: FormView, FormDelegate {
    
    var appointment: Appointement?
    var veterinarians: [Veterinarian]
    var animals: [Animal]
    
    init(appointment: Appointement?, veterinarians: [Veterinarian], animals: [Animal]) {
        self.appointment = appointment
        self.veterinarians = veterinarians
        self.animals = animals
        super.init(formFields: [])
        setupForm()
        print(veterinarians)
        print(animals)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupForm() {
        // Create form fields for the AppointmentForm
        let dateField = DateFormField(labelText: NSLocalizedString("date", comment: ""), placeholder: NSLocalizedString("appointement_date_placeholder", comment: "tes"), value: appointment?.date, minDate: Date(), datePickerMode: .dateAndTime)
        
        let animalsField = PickerFormField(values: animals.map { $0.name }, labelText: NSLocalizedString("animals_placeholder", comment: ""), placeholder: NSLocalizedString("animals", comment: ""), value: [animals], inputViewType: .picker)
        
        let veterinarianField = PickerFormField(values: veterinarians.map { $0.name }, labelText: NSLocalizedString("veterinarian_placeholder", comment: ""), placeholder: NSLocalizedString("veterinarian", comment: ""), value: [veterinarians], inputViewType: .picker)
        
        let descriptionField = TextFormField(labelText: NSLocalizedString("description", comment: ""), placeholder: NSLocalizedString("description_placeholder", comment: ""), value: appointment?.descriptionRdv)
        
        // Add the form fields to the AppointmentForm
        addFormField(dateField)
        addFormField(animalsField)
        addFormField(veterinarianField)
        addFormField(descriptionField)
        
        delegate = self
    }
    
    func getFormFields() -> [FormField] {
        return formFields
    }
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        switch field {
        case let dateField as DateFormField:
            if dateField.labelText == NSLocalizedString("date", comment: "") {
                appointment?.date = value as? Date
            }
        case let veterinarianField as PickerFormField:
            if veterinarianField.labelText == NSLocalizedString("veterinarian", comment: "") {
                // Handle selected veterinarian
            }
        case let animalsField as PickerFormField:
            if animalsField.labelText == NSLocalizedString("animals", comment: "") {
                // Handle selected animal
            }
        case let descriptionField as TextFormField:
            if descriptionField.labelText == NSLocalizedString("description", comment: "") {
                appointment?.descriptionRdv = value as? String
            }
        // Add additional cases for other form fields
        default:
            break
        }
    }
}
