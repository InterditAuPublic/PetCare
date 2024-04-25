//
//  AppointmentForm.swift
//  PetCare
//
//  Created by Melvin Poutrel on 17/03/2024.
//

import UIKit

class AppointmentForm: FormView {
    
    var appointment: Appointement?
    var veterinarians: [Veterinarian]
    var animals: [Animal]
    
    init(appointment: Appointement?, veterinarians: [Veterinarian], animals: [Animal]) {
        self.appointment = appointment
        self.veterinarians = veterinarians
        self.animals = animals
        super.init(formFields: [])
        setupForm()
        
        
        // Debugging: Print veterinarians and animals
        print("Veterinarians passed to the picker: \(veterinarians)")
        print("Animals passed to the picker: \(animals)")
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupForm() {
        
        // Create form fields for the AppointmentForm
        let dateField = DateFormField(labelText: NSLocalizedString("date", comment: ""), placeholder: NSLocalizedString("appointment_date_placeholder", comment: ""), value: appointment?.date, minDate: Date(), datePickerMode: .dateAndTime)
        
        // Pass the array of animals directly
        let animalsField = PickerFormField(value: appointment?.animals, values: animals, labelText: NSLocalizedString("animals_placeholder", comment: ""), placeholder: NSLocalizedString("animals", comment: ""), inputViewType: .picker)
        
        // Pass the array of veterinarians directly, don't map it to names
        let veterinarianField = PickerFormField(value: appointment?.veterinarian, values: veterinarians, labelText: NSLocalizedString("veterinarian", comment: ""), placeholder: NSLocalizedString("veterinarian_placeholder", comment: ""), inputViewType: .picker)
        
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
    
}
    
    extension AppointmentForm: FormDelegate {
        func formDidUpdateValue(_ value: Any?, forField field: FormField) {
            switch field {
            case let dateField as DateFormField:
                appointment?.date = value as? Date
            case let veterinarianField as PickerFormField:
                if let selectedVetName = value as? String {
                    appointment?.veterinarian = veterinarians.first { $0.name == selectedVetName }
                    // Log the selected veterinarian name
                    print("Selected veterinarian name: \(selectedVetName)")
                }
            case let animalsField as PickerFormField:
                if let selectedAnimalNames = value as? [String] {
                    appointment?.animals = animals.filter { selectedAnimalNames.contains($0.name ?? "") }
                    // Log the selected animals names
                    print("Selected animals names: \(selectedAnimalNames)")
                }
            case let descriptionField as TextFormField:
                appointment?.descriptionRdv = value as? String
            default:
                break
            }
        }
}
