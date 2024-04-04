//
//  AnimalForm.swift
//  PetCare
//
//  Created by Melvin Poutrel on 15/01/2024.
//

import UIKit

class AnimalForm: FormView, FormDelegate {
    
    var animal: Animal?
    let speciesOptions: [Species] = Species.allCases
    
    init(animal: Animal?) {
        super.init(formFields: [])
        self.animal = animal
        setupForm()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupForm() {
        
        let test = Species.allCases.map({ Specie in
            return Specie.text
        })
        
        print(test)
        
        // Create form fields for the AnimalForm
        let imageField = ImageFormField(value: "animal_default_image", picker: true)
        let identifierField = TextFormField(labelText: NSLocalizedString("identifier", comment: ""), placeholder: NSLocalizedString("identifier_placeholder", comment: ""), value: animal?.identifier)
        let nameField = TextFormField(labelText: NSLocalizedString("name", comment: ""), placeholder: NSLocalizedString("name_placeholder", comment: ""), value: animal?.name)
        
        let species = PickerFormField(values: ["chien", "chat"], labelText: NSLocalizedString("species", comment: ""), value: "chat")
        
        let genderField = SegmentFormField(labelText: NSLocalizedString("sex", comment: ""), value: true, values: ["Male", "Female"])
        let breedField = TextFormField(labelText: NSLocalizedString("breed", comment: ""), placeholder: NSLocalizedString("breed_placeholder", comment: ""), value: animal?.breed)
        let birthDateField = DateFormField(labelText: NSLocalizedString("birthdate", comment: ""), placeholder: NSLocalizedString("birthdate_placeholder", comment: ""), value: animal?.birthdate, maxDate: Date(), datePickerMode: .date)
        let weightField = TextFormField(labelText: NSLocalizedString("weight", comment: ""), placeholder: NSLocalizedString("weight_placeholder", comment: ""), value: animal?.weight)
        let colorField = TextFormField(labelText: NSLocalizedString("color", comment: ""), placeholder: NSLocalizedString("color_placeholder", comment: ""), value: animal?.color)
        let commentsFields = TextFormField(labelText: NSLocalizedString("comments", comment: ""), placeholder: NSLocalizedString("comments_placeholder", comment: ""), value: animal?.comments)
        
        
        // Add the form fields to the AnimalForm
        addFormField(imageField)
        addFormField(identifierField)
        addFormField(nameField)
        addFormField(species)
        addFormField(genderField)
        addFormField(breedField)
        addFormField(birthDateField)
        addFormField(weightField)
        addFormField(colorField)
        addFormField(commentsFields)
        
        delegate = self
    }
    
    func getFormFields() -> [FormField] {
        return formFields
    }
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        switch field {
        case let textField as TextFormField:
            switch textField.labelText {
            case NSLocalizedString("identifier", comment: ""):
                animal?.identifier = value as? String
            case NSLocalizedString("name", comment: ""):
                animal?.name = value as? String
            case NSLocalizedString("breed", comment: ""):
                animal?.breed = value as? String
            case NSLocalizedString("weight", comment: ""):
                animal?.weight = value as? String
            case NSLocalizedString("color", comment: ""):
                animal?.color = value as? String
            case NSLocalizedString("comments", comment: ""):
                animal?.comments = value as? String
            default:
                break
            }
        case let pickerField as PickerFormField:
            if pickerField.labelText == NSLocalizedString("species", comment: "") {
                animal?.species = value as? Species
            }
        case let dateField as DateFormField:
            if dateField.labelText == NSLocalizedString("birthdate", comment: "") {
                animal?.birthdate = value as? Date
            }
        default:
            break
        }
    }
}

