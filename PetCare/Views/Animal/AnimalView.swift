//
//  AnimalView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 15/01/2024.
//

import UIKit
import DTTextField

class AnimalView: UIScrollView {
    
    // MARK: - Properties

    // Labels
    private let sexLabel = createLabel(with: "sex")
    private let sterilizedLabel = createLabel(with: "sterialized")
    private let speciesLabel = createLabel(with: "species")
    private let birthdateLabel = createLabel(with: "birthdate")
    
    // Text fields
    let nameTextField = createDTTextField(placeholder: "name_placeholder")
    let identifierTextField = createDTTextField(placeholder: "identifier_placeholder")
    let sexSegmentedControl = createSegmentedControl(items: ["Male", "Female"])
    let sterilizedSegmentedControl = createSegmentedControl(items: ["no", "yes"])
    let speciesSegmentedControl = createSegmentedControl(items: ["Dog", "Cat"])
    let breedTextField = createDTTextField(placeholder: "breed_placeholder")
    let birthdatePicker = createDatePicker()
    let weightTextField = createDTNumberField(placeholder: "weight_placeholder")
    let colorTextField = createDTTextField(placeholder: "color_placeholder")
    let commentsTextField = createDTTextField(placeholder: "comments_placeholder")
    
    // Image container view
    let imageContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
       
        return containerView
    }()
    
    var imageView: UIImageView {
        return imageContainerView.subviews.first(where: { $0 is UIImageView }) as! UIImageView
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func populate(with animal: Animal) {
        nameTextField.text = animal.name
        identifierTextField.text = animal.identifier
        sexSegmentedControl.selectedSegmentIndex = animal.sexe ? 1 : 0
        speciesSegmentedControl.selectedSegmentIndex = animal.species == .dog ? 0 : 1
        sterilizedSegmentedControl.selectedSegmentIndex = animal.sterilized ? 1 : 0
        breedTextField.text = animal.breed
        birthdatePicker.date = animal.birthdate ?? Date()

        // Localized weight
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        if let weight = animal.weight {
            weightTextField.text = numberFormatter.string(from: NSNumber(value: weight))
        } else {
            weightTextField.text = ""
        }

        colorTextField.text = animal.color
        commentsTextField.text = animal.comments
        imageView.image = animal.image != nil ? UIImage(data: animal.image!) : nil
    }
    
    func toggleError(field: DTTextField, errorMessage: String ) {
        field.errorMessage = errorMessage
        field.showError()
        field.canShowBorder = true
        adjustContentSize()
    }
    
    // MARK: - Private Methods
    
    @objc private func selectImageTapped() {
        // Implementation for image selection
    }

    private func setupView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        containerView.addSubview(imageContainerView)
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            imageContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageContainerView.heightAnchor.constraint(equalToConstant: 200),
            imageContainerView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
            identifierTextField,
            sexLabel, sexSegmentedControl,
            sterilizedLabel,
            sterilizedSegmentedControl,
            speciesLabel, speciesSegmentedControl,
            breedTextField,
            birthdateLabel, birthdatePicker,
            weightTextField,
            colorTextField,
            commentsTextField
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        [nameTextField, identifierTextField, breedTextField, weightTextField, colorTextField, commentsTextField].forEach {
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImageTapped))
        imageView.addGestureRecognizer(tapGesture)
        
        [nameTextField, identifierTextField, breedTextField, weightTextField, colorTextField, commentsTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @objc private func textFieldDidChange() {
        adjustContentSize()
    }
    
    private func adjustContentSize() {
        layoutIfNeeded()
        contentSize = CGSize(width: frame.width, height: subviews.first?.frame.height ?? frame.height)
    }
    
    // MARK: - Factory Methods

    private static func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = NSLocalizedString(text, comment: "")
        label.textColor = .label
        return label
    }
    
    private static func createDTTextField(placeholder: String) -> DTTextField {
        let textField = DTTextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .orange
        textField.placeholder = NSLocalizedString(placeholder, comment: "")
        return textField
    }
    
    private static func createDTNumberField(placeholder: String) -> DTTextField {
        let textField = DTTextField()
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.tintColor = .orange
        textField.placeholder = NSLocalizedString(placeholder, comment: "")
        return textField
    }
    
    private static func createSegmentedControl(items: [String]) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items.map { NSLocalizedString($0, comment: "") })
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }
    
    private static func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.tintColor = .orange
        datePicker.maximumDate = Date()
        datePicker.locale = Locale.current
        return datePicker
    }
}
