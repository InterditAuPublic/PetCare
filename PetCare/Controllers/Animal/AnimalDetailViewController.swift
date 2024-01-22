import UIKit

class AnimalDetailViewController: UIViewController {

    var animalDetailView: AnimalDetailView?
    var selectedAnimal: Animal?

    init(selectedAnimal: Animal) {
        self.selectedAnimal = selectedAnimal
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        animalDetailView = AnimalDetailView(animal: selectedAnimal)
        guard let animalDetailView = animalDetailView else { return }

        view.addSubview(animalDetailView)
        animalDetailView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animalDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animalDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animalDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animalDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        animalDetailView.animalForm?.delegate = self

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func saveButtonTapped() {
        guard let animalForm = animalDetailView?.animalForm else { return }
        let formFields = animalForm.getFormFields()
        
        guard let name = formFields[2].value as? String, !name.isEmpty else {
//            showAlert(message: "Vous devez entrer un nom pour votre animal")
            return
        }

        // Validate species
        guard let speciesRawValue = formFields[3].value as? String,
              let specie = Species(rawValue: speciesRawValue) else { // TODO: If not changed unable to save the changes
//            showAlert(message: "Vous devez sélectionner une espèce pour votre animal")
            return
        }
        
        var animal = Animal()
        animal.image = formFields[0].value as? String
        animal.identifier = formFields[1].value as? String
        animal.sexe = formFields[4].value as? Bool
        animal.breed = formFields[5].value as? String
        animal.birthdate = formFields[6].value as? Date
        animal.weight = formFields[7].value as? String
        animal.color = formFields[8].value as? String
        animal.comments = formFields[9].value as? String
        animal.name = name
        animal.species = specie
        
        print("ANIMAL : \(animal)")
      // save the animal to the database
      CoreDataManager.shared.updateAnimal(animal: animal)
    }

}

extension AnimalDetailViewController: FormDelegate {
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        // change the value of the animal 
        print("In update")
     // update the animal in the database
    }
}
