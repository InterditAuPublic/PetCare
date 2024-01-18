import UIKit

class AnimalForm: FormView, FormDelegate {
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        
        switch field.labelText {
        case "Identifier":
            animal?.identifier = value as? String
        case "Name":
            animal?.name = value as? String
        case "Species":
            animal?.species = value as? Species
        case "Breed":
            animal?.breed = value as? String
        case "Birth Date":
            animal?.birthdate = value as? Date
        case "Weight":
            animal?.weight = value as? String
        case "Color":
            animal?.color = value as? String
        case "Comments":
            animal?.comments = value as? String
        default:
            break
        }
    }
    
    var animal: Animal?
    let speciesOptions: [Species] = Species.allSpecies
    
    init(animal: Animal?) {
        super.init(formFields: [])
        self.animal = animal
        setupForm()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupForm() {
        // Create form fields for the AnimalForm
        let imageField = ImageFormField(value: "animal_default_image")
        let identifierField = TextFormField(labelText: "Identifier", placeholder: "Enter identifier", value: animal?.identifier)
        let nameField = TextFormField(labelText: "Name", placeholder: "Enter name", value: animal?.name)
        let species = PickerFormField(values: Species.allSpecies, labelText: "Species", value:animal?.species?.rawValue ?? Species.cat.rawValue) // TODO: HERE SET THE DEFAULT VALUE
        let genderField = SegmentFormField(labelText: "Gender", value: true, values: ["Male", "Female"])
        let breedField = TextFormField(labelText: "Breed", placeholder: "Enter breed", value: animal?.breed)
        let birthDateField = DateFormField(labelText: "Birth Date", placeholder: "Select birth date", value: animal?.birthdate)
        let weightField = TextFormField(labelText: "Weight", placeholder: "Enter weight", value: animal?.weight)
        let colorField = TextFormField(labelText: "Color", placeholder: "Enter color", value: animal?.color)
        let commentsFields = TextFormField(labelText: "Comments", placeholder: "Comments", value: animal?.comments)
        
        var test = Species(rawValue: "Cat")
        print(" WOWOWOWO \(test) ")
        
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
}

