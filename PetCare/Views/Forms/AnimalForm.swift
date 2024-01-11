import UIKit

class AnimalForm: FormView, AddAnimalDelegate {

  var animal: Animal?

    // MARK: - Initializers

    init(frame: CGRect, animal: Animal?) {
        super.init(frame: frame)
        // Setup the form

        if let animal = animal {
            setupForm(withAnimal: animal)
        } else {
            setupForm(withAnimal: nil)
        }

    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupForm(withAnimal: animal)
    }

    // MARK: - Form Configuration

    private func setupForm(withAnimal animal: Animal?) {

        // Create form fields
        let identifierField = TextFormField(labelText: "Identifiant", placeholder: "Identifiant", value: animal?.identifier ?? "")
        let nameField = TextFormField(labelText: "Nom", placeholder: "Nom de l'animal", value: animal?.name ?? "")
        let breedField = TextFormField(labelText: "Race", placeholder: "Race de l'animal", value: animal?.breed ?? "")
        let birthDateField = DateFormField(labelText: "Date de naissance", placeholder: "Date de naissance de l'animal", value: animal?.birthdate ?? Date())
        let weightField = TextFormField(labelText: "Poids", placeholder: "Poids de l'animal", value: animal?.weight ?? "")
        let colorField = TextFormField(labelText: "Couleur", placeholder: "Couleur de l'animal", value: animal?.color ?? "")
        let commentsField = TextFormField(labelText: "Commentaires", placeholder: "Commentaires sur l'animal", value: animal?.comments ?? "")

        addFormField(identifierField)
        addFormField(nameField)
        addFormField(breedField)
        addFormField(birthDateField)
        addFormField(weightField)
        addFormField(colorField)
        addFormField(commentsField)

    }


    // MARK: - AddAnimalDelegate Methods

    func selectedSpecies(name: String, species: Species) {
        // Handle species selection if needed
    }

    func nextButtonTapped(with animalInfo: [String: Any]) {
print("tapped")
        animal?.name = animalInfo["name"] as? String ?? ""
        animal?.breed = animalInfo["breed"] as? String ?? ""
    }
}
