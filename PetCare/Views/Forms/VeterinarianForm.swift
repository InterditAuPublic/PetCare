//
//  VeterinarianForm.swift
//  PetCare
//
//  Created by Melvin Poutrel on 15/01/2024.
//

import UIKit

class VeterinarianForm: FormView, FormDelegate {
    
    var veterinarian: Veterinarian?
    
    init(veterinarian: Veterinarian?) {
        super.init(formFields: [])
        self.veterinarian = veterinarian
        setupForm()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupForm() {
        let image = ImageFormField(value: "veterinary")
        let name = TextFormField(labelText: NSLocalizedString("veterinarian_name", comment: ""), placeholder: NSLocalizedString("veterinarian_name_placeholder", comment: ""), value: veterinarian?.name)
        let address = TextFormField(labelText: NSLocalizedString("veterinarian_adresse", comment: ""), placeholder: NSLocalizedString("veterinarian_adresse_placeholder", comment: "") , value: veterinarian?.address)
        let zipcode = TextFormField(labelText: NSLocalizedString("zipcode", comment: ""), placeholder: NSLocalizedString("veterinarian_zipcode_placeholder", comment: ""), value: veterinarian?.zipcode)
        let city = TextFormField(labelText: NSLocalizedString("veterinarian_city", comment: ""), placeholder: NSLocalizedString("veterinarian_city_placeholder", comment: ""), value: veterinarian?.city)
        let countryPicker = PickerFormField(values: ["Fr","En","De","Pl","Be","It","Es","Pt","Nl","Sw"], labelText: NSLocalizedString("veterinarian_country", comment: ""))
        let phone = TextFormField(labelText: NSLocalizedString("veterinarian_phone", comment: ""), placeholder:NSLocalizedString("veterinarian_phone_placeholder", comment: ""), value: veterinarian?.phone)
        let email = TextFormField(labelText: NSLocalizedString("veterinarian_email", comment: ""), placeholder: NSLocalizedString("veterinarian_email_placeholder", comment: ""), value: veterinarian?.email)
        let note = TextFormField(labelText: NSLocalizedString("veterinarian_note", comment: ""), placeholder: NSLocalizedString("veterinarian_note_placeholder", comment: ""), value: veterinarian?.note)
        
        addFormField(image)
        addFormField(name)
        addFormField(address)
        addFormField(zipcode)
        addFormField(city)
        addFormField(countryPicker)
        addFormField(phone)
        addFormField(email)
        addFormField(note)
        
        
        delegate = self
    }
    
    func getFormFields() -> [FormField] {
        return formFields
    }
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        
        switch field {
        case let name as TextFormField:
            print("name: \(name.value)")
        case let address as TextFormField:
            print("address: \(address.value)")
        case let zipcode as TextFormField:
            print("zipcode: \(zipcode.value)")
        case let city as TextFormField:
            print("city: \(city.value)")
        case let country as PickerFormField:
            
            print("country: \(country.value)")
        case let phone as TextFormField:
            print("phone: \(phone.value)")
        case let email as TextFormField:
            print("email: \(email.value)")
        case let note as TextFormField:
            print("note: \(note.value)")
        default:
            print("default")
        }
        
    }
}


