import UIKit

class AnimalForm: FormView, FormDelegate {


    var animal: Animal?

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
        let imageField = ImageFormField()
        let identifierField = TextFormField(labelText: "Identifier", placeholder: "Enter identifier", value: animal?.identifier)
        let nameField = TextFormField(labelText: "Name", placeholder: "Enter name", value: animal?.name)
        let genderField = SegmentFormField(labelText: "Gender", placeholder: "Male", segments: ["Male", "Female"])
        let breedField = TextFormField(labelText: "Breed", placeholder: "Enter breed", value: animal?.breed)
        let birthDateField = DateFormField(labelText: "Birth Date", placeholder: "Select birth date", value: animal?.birthdate)
        let weightField = TextFormField(labelText: "Weight", placeholder: "Enter weight", value: animal?.weight)
        let colorField = TextFormField(labelText: "Color", placeholder: "Enter color", value: animal?.color)
        let commentsFields = TextFormField(labelText: "Comments", placeholder: "Comments", value: animal?.comments)

        // Add the form fields to the AnimalForm
        addFormField(imageField)
        addFormField(identifierField)
        addFormField(nameField)
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
        print("In update")
        // Handle the form field update
            if let textValue = value as? String {
                switch field.labelText {
                case "Identifier":
                    animal?.identifier = textValue
                case "Name":
                    animal?.name = textValue
                case "Breed":
                    animal?.breed = textValue
                case "Weight":
                    animal?.weight = textValue
                case "Color":
                    animal?.color = textValue
                default:
                    break
                }
            } else if let dateValue = value as? Date {
                if field.labelText == "Birth Date" {
                    animal?.birthdate = dateValue
                }
            }
        }
}
