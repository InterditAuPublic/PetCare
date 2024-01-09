//
//  AddAnimalView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//


import UIKit

class AddAnimalView: UIScrollView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupPicker()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupPicker()
    }
    
    var animalDelegate: AddAnimalDelegate?
    
    // MARK: - Properties
    let speciesOptions: [Species] = Species.allSpecies
    
    private let contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
    

    // MARK: - UI Configuration
    private func setupUI() {
        addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.addSubview(animalImageView)
        contentView.addSubview(identifireLabel)
        contentView.addSubview(identifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(speciesLabel)
        contentView.addSubview(speciesPicker)
        contentView.addSubview(sexSegmentedControl)
        contentView.addSubview(birthDateLabel)
        contentView.addSubview(birthDatePicker)
        contentView.addSubview(weightLabel)
        contentView.addSubview(weightTextField)
        contentView.addSubview(heightLabel)
        contentView.addSubview(heightTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorTextField)
        contentView.addSubview(veterinarianLabel)
        contentView.addSubview(veterinarianTextField)
        contentView.addSubview(lastVisitLabel)
        contentView.addSubview(lastVisitDatePicker)
        contentView.addSubview(alergiesLabel)
        contentView.addSubview(alergiesTextField)
        contentView.addSubview(commentsLabel)
        contentView.addSubview(commentsTextField)
        contentView.addSubview(nextButton)

        

//        // Make the image view rounded
//        animalImageView.layer.cornerRadius = 75  // Half of the height (or width) for a perfect circle
//        animalImageView.clipsToBounds = true
//        animalImageView.contentMode = .scaleAspectFit
        
        /// Image view constraints
        NSLayoutConstraint.activate([
            animalImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            // animalImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            // animalImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            animalImageView.heightAnchor.constraint(equalToConstant: 150),
            // Set the width of the image view to be equal to its height
            animalImageView.widthAnchor.constraint(equalTo: animalImageView.heightAnchor),
            
            // center the image view horizontally
            animalImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            
            
        ])
        
        /// Identifier label constraints
        NSLayoutConstraint.activate([
                identifireLabel.topAnchor.constraint(equalTo: animalImageView.bottomAnchor, constant: 20),
                identifireLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                identifireLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])

        /// Identifier text field constraints
        NSLayoutConstraint.activate([
            identifier.topAnchor.constraint(equalTo: identifireLabel.bottomAnchor, constant: 10),
            identifier.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            identifier.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Name label constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: identifier.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Name text field constraints
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Species label constraints
        NSLayoutConstraint.activate([
            speciesLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            speciesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            speciesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        /// Species picker constraints
        NSLayoutConstraint.activate([
            speciesPicker.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 0),
            speciesPicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            speciesPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Sex segmented control contraints
        NSLayoutConstraint.activate([
            sexSegmentedControl.topAnchor.constraint(equalTo: speciesPicker.bottomAnchor, constant: 20),
            sexSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sexSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Birthdate label constraints
        NSLayoutConstraint.activate([
            birthDateLabel.topAnchor.constraint(equalTo: sexSegmentedControl.bottomAnchor, constant: 20),
            birthDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            birthDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        /// Birthsate date picker contraints
        NSLayoutConstraint.activate([
            birthDatePicker.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: 10),
            birthDatePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            birthDatePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Weight label constraints
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: birthDatePicker.bottomAnchor, constant: 20),
            weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Weight text field constaints
        NSLayoutConstraint.activate([
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10),
            weightTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weightTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Height label constraints
        NSLayoutConstraint.activate([
            heightLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            heightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Height text field constaints
        NSLayoutConstraint.activate([
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10),
            heightTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            heightTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Color label constraints
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            colorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            colorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Color text field constaints
        NSLayoutConstraint.activate([
            colorTextField.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10),
            colorTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            colorTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Veterinarian label constraints
        NSLayoutConstraint.activate([
            veterinarianLabel.topAnchor.constraint(equalTo: colorTextField.bottomAnchor, constant: 20),
            veterinarianLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            veterinarianLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Veterinarian text field constaints
        NSLayoutConstraint.activate([
            veterinarianTextField.topAnchor.constraint(equalTo: veterinarianLabel.bottomAnchor, constant: 10),
            veterinarianTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            veterinarianTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Last visit label constraints
        NSLayoutConstraint.activate([
            lastVisitLabel.topAnchor.constraint(equalTo: veterinarianTextField.bottomAnchor, constant: 20),
            lastVisitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lastVisitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Last visit date picker contraints
        NSLayoutConstraint.activate([
            lastVisitDatePicker.topAnchor.constraint(equalTo: lastVisitLabel.bottomAnchor, constant: 10),
            lastVisitDatePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lastVisitDatePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Alergies label constraints
        NSLayoutConstraint.activate([
            alergiesLabel.topAnchor.constraint(equalTo: lastVisitDatePicker.bottomAnchor, constant: 20),
            alergiesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            alergiesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Alergies text field contraints
        NSLayoutConstraint.activate([
            alergiesTextField.topAnchor.constraint(equalTo: alergiesLabel.bottomAnchor, constant: 10),
            alergiesTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            alergiesTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Comments label constraints
        NSLayoutConstraint.activate([
            commentsLabel.topAnchor.constraint(equalTo: alergiesTextField.bottomAnchor, constant: 20),
            commentsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            commentsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Comments text filed contraints
        NSLayoutConstraint.activate([
            commentsTextField.topAnchor.constraint(equalTo: commentsLabel.bottomAnchor, constant: 10),
            commentsTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            commentsTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

        /// Next button constraints
            NSLayoutConstraint.activate([
                nextButton.topAnchor.constraint(equalTo: commentsTextField.bottomAnchor, constant: 20),
                nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])

            nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)

            /// Add constraints for the content view
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: widthAnchor)
            ])
    }

    // MARK: - UI Elements
    
    let identifireLabel: UILabel = {
        let label = UILabel()
        label.text = "Indentifiant"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let identifier: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Identifiant de l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nom"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nom de l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Espèce"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let speciesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Espèce de l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // create a selector for the sex of the animal
    let sexSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Mâle", "Femelle"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    let birthDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date de naissance"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let birthDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .inline

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Poids"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Poids de l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Taille"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Taille de l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Couleur"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let colorTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Couleur de l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let veterinarianLabel: UILabel = {
        let label = UILabel()
        label.text = "Vétérinaire"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let veterinarianTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Vétérinaire de l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let lastVisitLabel: UILabel = {
        let label = UILabel()
        label.text = "Dernière visite"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let lastVisitDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    let alergiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Allergies"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let alergiesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Allergies de l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Commentaires"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let commentsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Commentaires sur l'animal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Suivant", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Picker View

    let speciesPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()


    // MARK: - Picker View Configuration
    private func setupPicker() {
        speciesPicker.delegate = self
        speciesPicker.dataSource = self
    }
    
    @objc private func nextButtonTapped() {
        // Get values from various UI elements
        let identifierValue = identifier.text ?? ""
        let nameValue = nameTextField.text ?? ""
        let speciesValue = speciesTextField.text ?? ""
        let sexValue = sexSegmentedControl.selectedSegmentIndex == 0 ? "Mâle" : "Femelle"
        let birthDateValue = birthDatePicker.date
        let weightValue = weightTextField.text ?? ""
        let heightValue = heightTextField.text ?? ""
        let colorValue = colorTextField.text ?? ""
        let veterinarianValue = veterinarianTextField.text ?? ""
        let lastVisitValue = lastVisitDatePicker.date
        let alergiesValue = alergiesTextField.text ?? ""
        let commentsValue = commentsTextField.text ?? ""
        let imageValue = animalImageView.image?.pngData() ?? Data()

        // Create a dictionary or a custom struct to hold the values
        let animalInfo: [String: Any] = [
            "identifier": identifierValue,
            "name": nameValue,
            "species": speciesValue,
            "sex": sexValue,
            "birthDate": birthDateValue,
            "weight": weightValue,
            "height": heightValue,
            "color": colorValue,
            "veterinarian": veterinarianValue,
            "lastVisit": lastVisitValue,
            "alergies": alergiesValue,
            "comments": commentsValue,
            "image": imageValue
        ]

        // Call the delegate method to pass the information
        animalDelegate?.nextButtonTapped(with: animalInfo)
    }
}

// Set the delegate of the text field to the view controller
extension AddAnimalView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddAnimalView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return speciesOptions[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedSpecies = speciesOptions[row]
        animalDelegate?.selectedSpecies(name: nameTextField.text ?? "", species: selectedSpecies)
    }
}

extension AddAnimalView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return speciesOptions.count
    }
}

protocol AddAnimalDelegate {
    func selectedSpecies(name: String, species: Species)
    func nextButtonTapped(with animalInfo: [String: Any])
}
