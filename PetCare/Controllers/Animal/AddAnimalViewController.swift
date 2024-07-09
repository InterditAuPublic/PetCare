import UIKit

class AddAnimalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties

    let addAnimalView = AnimalView()
    
    override func loadView() {
        view = addAnimalView
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("add_animal_title", comment: "")
        view.backgroundColor = .white
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAnimal))
        navigationItem.rightBarButtonItem = addButton
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        addAnimalView.imageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions

    @objc private func saveAnimal() {
        guard let name = addAnimalView.nameTextField.text, !name.isEmpty else {
            addAnimalView.toggleError(field: addAnimalView.nameTextField, errorMessage: NSLocalizedString("name_error", comment: ""))
            return
        }

        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal

        guard let weightText = addAnimalView.weightTextField.text, !weightText.isEmpty, let weightNumber = numberFormatter.number(from: weightText) else {
            addAnimalView.toggleError(field: addAnimalView.weightTextField, errorMessage: NSLocalizedString("weight_format_error", comment: ""))
            return
        }

        let weight = weightNumber.doubleValue

        let image = addAnimalView.imageView.image

        let animalForm = AnimalForm(
            identifier: addAnimalView.identifierTextField.text,
            name: name,
            sexe: addAnimalView.sexSegmentedControl.selectedSegmentIndex == 0 ? false : true,
            sterilized: addAnimalView.sterilizedSegmentedControl.selectedSegmentIndex == 0 ? false : true,
            species: Species.allCases[addAnimalView.speciesSegmentedControl.selectedSegmentIndex],
            breed: addAnimalView.breedTextField.text,
            birthdate: addAnimalView.birthdatePicker.date,
            weight: weight,
            color: addAnimalView.colorTextField.text,
            comments: addAnimalView.commentsTextField.text,
            image: image?.pngData()
        )

        CoreDataManager.shared.saveAnimal(form: animalForm)

        navigationController?.popViewController(animated: true)
    }
    


    
    @objc private func openImagePicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            addAnimalView.imageView.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
