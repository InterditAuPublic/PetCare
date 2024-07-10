//
//  AppointementView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit
import DTTextField

class AppointmentView: UIScrollView {

    // MARK: - Properties

    private let dateLabel: UILabel = createLabel(with: "Date: ")
    private let veterinarianLabel: UILabel = createLabel(with: "Veterinarian: ")
    private let animalsLabel: UILabel = createLabel(with: "Animaux : ")

    let datePicker: UIDatePicker = createDatePicker()
    let veterinarianPicker: UIPickerView = createPickerView()
    let animalsTableView: UITableView = createTableView()
    let descriptionTextField: DTTextField = createDTTextField(placeholder: NSLocalizedString("comments_placeholder", comment: ""))

    var veterinarians: [Veterinarian] = []
    var animals: [Animal] = []

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    // Populate the view with the data of the appointment
    func populate(with appointment: Appointment) {
        datePicker.date = appointment.date
        descriptionTextField.text = appointment.descriptionRdv
    }

    // MARK: - Private Methods

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

        let stackView = UIStackView(arrangedSubviews: [
            dateLabel, datePicker,
            veterinarianLabel, veterinarianPicker,
            animalsLabel, animalsTableView,
            descriptionTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])

        // Adding a height constraint for the animalsTableView to ensure it appears
        animalsTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    // MARK: - Utility Methods

    private static func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = NSLocalizedString(text, comment: "")
        return label
    }

    private static func createDTTextField(placeholder: String) -> DTTextField {
        let textField = DTTextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .orange
        textField.placeholder = placeholder
        return textField
    }

    private static func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        return pickerView
    }

    private static func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.minimumDate = .now
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }

    private static func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }

    // Display an error message below the text field
    func toggleError(field: DTTextField, errorMessage: String ) {
        field.errorMessage = errorMessage
        field.showError()
        field.canShowBorder = true
    }
}
