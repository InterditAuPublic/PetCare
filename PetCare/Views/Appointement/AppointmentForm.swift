//
//  AppointmentForm.swift
//  PetCare
//
//  Created by Melvin Poutrel on 17/03/2024.
//

import UIKit

class AppointmentForm: FormView, FormDelegate {
    
    var appointment: Appointement?
    
    init(appointment: Appointement?) {
        super.init(formFields: [])
        self.appointment = appointment
        setupForm()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupForm() {
        // Create form fields for the AppointmentForm
        let dateField = DateFormField(labelText: NSLocalizedString("date", comment: ""), placeholder: NSLocalizedString("date_placeholder", comment: ""), value: appointment?.date)
        let hoursField = TextFormField(labelText: NSLocalizedString("hours", comment: ""), placeholder: NSLocalizedString("hours_placeholder", comment: ""), value: appointment?.hours)
        let descriptionField = TextFormField(labelText: NSLocalizedString("description", comment: ""), placeholder: NSLocalizedString("description_placeholder", comment: ""), value: appointment?.descriptionRdv)
        // Add additional fields as needed
        
        // Add the form fields to the AppointmentForm
        addFormField(dateField)
        addFormField(hoursField)
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
        case let hoursField as TextFormField:
            if hoursField.labelText == NSLocalizedString("hours", comment: "") {
                appointment?.hours = value as? String
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
