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
    
    var animalForm: AnimalForm!
    
    init(appointment: Appointement?, veterinarians: [Veterinarian], animals: [Animal]) {
        self.appointment = appointment
        self.veterinarians = veterinarians
        self.animals = animals
        super.init(formFields: [])
        setupForm()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupForm() {
        // Create form fields for the AppointmentForm
        let dateField = DateFormField(labelText: NSLocalizedString("date", comment: ""), placeholder: NSLocalizedString("date_placeholder", comment: ""), value: appointment?.date, datePickerMode: .dateAndTime)
        let veterinarianField = PickerFormField(values: veterinarians.map { $0.name }, labelText: NSLocalizedString("veterinarian", comment: ""), placeholder: NSLocalizedString("veterinarian_placeholder", comment: ""), value: nil, inputViewType: .picker)
        let animalsField = PickerFormField(values: animals.map { $0.name }, labelText: NSLocalizedString("animals", comment: ""), placeholder: NSLocalizedString("animals_placeholder", comment: ""), value: nil, inputViewType: .picker)
        let descriptionField = TextFormField(labelText: NSLocalizedString("description", comment: ""), placeholder: NSLocalizedString("description_placeholder", comment: ""), value: appointment?.descriptionRdv)
        
        // Add additional fields as needed
        
        // Add the form fields to the AppointmentForm
        addFormField(dateField)
        addFormField(veterinarianField)
        addFormField(animalsField)
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
