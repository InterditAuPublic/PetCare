//
//  EditAppointmentViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 20/06/2024.
//

import UIKit

class EditAppointmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    let editAppointmentView = AppointmentView()
    var appointment: Appointment
    var veterinarians: [Veterinarian] = []
    var animals: [Animal] = []
    var selectedAnimals: [Animal] = []

    // MARK: - Initializers
    
    init(appointment: Appointment) {
        self.appointment = appointment
        super.init(nibName: nil, bundle: nil)
        self.selectedAnimals = appointment.animals
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func loadView() {
        view = editAppointmentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("edit_appointment_title", comment: "")
        view.backgroundColor = .white

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAppointment))
        navigationItem.rightBarButtonItem = saveButton

        loadVeterinarians()
        loadAnimals()

        editAppointmentView.veterinarianPicker.delegate = self
        editAppointmentView.veterinarianPicker.dataSource = self
        editAppointmentView.animalsTableView.delegate = self
        editAppointmentView.animalsTableView.dataSource = self

        editAppointmentView.animalsTableView.register(SelectAnimalTableViewCell.self, forCellReuseIdentifier: SelectAnimalTableViewCell.reuseIdentifier)
        
        // Populate the view with existing appointment data
        editAppointmentView.populate(with: appointment)
        if let selectedVetIndex = veterinarians.firstIndex(where: { $0.id == appointment.veterinarian.id }) {
            editAppointmentView.veterinarianPicker.selectRow(selectedVetIndex, inComponent: 0, animated: false)
        }
    }

    // MARK: - Actions

    /// Save the appointment with the updated data
    @objc private func saveAppointment() {
        guard let selectedVeterinarianIndex = editAppointmentView.veterinarianPicker.selectedRow(inComponent: 0) as Int?,
              veterinarians.indices.contains(selectedVeterinarianIndex) else {
            // Show an alert if no veterinarian is selected
            showAlert(title: NSLocalizedString("no_veterinarian_selected", comment: ""), message: NSLocalizedString("select_veterinarian", comment: ""))
            return
        }

        guard !selectedAnimals.isEmpty else {
            // Show an alert if no animals are selected
            showAlert(title: NSLocalizedString("no_animal_selected", comment: ""), message: NSLocalizedString("select_animal", comment: ""))
            return
        }

        let selectedVeterinarian = veterinarians[selectedVeterinarianIndex]

        let updatedAppointment = AppointmentForm(
            id: appointment.id,
            date: editAppointmentView.datePicker.date,
            descriptionRdv: editAppointmentView.descriptionTextField.text,
            veterinarian: selectedVeterinarian,
            animals: selectedAnimals
        )

        CoreDataManager.shared.updateAppointment(appointment: updatedAppointment)

        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Private Methods

    /// Load the veterinarians from CoreData and populate the picker
    private func loadVeterinarians() {
        veterinarians = CoreDataManager.shared.fetchVeterinarians() ?? []
        editAppointmentView.veterinarianPicker.reloadAllComponents()
    }

    /// Load the animals from CoreData and populate the table view
    private func loadAnimals() {
        animals = CoreDataManager.shared.fetchAnimals() ?? []
        editAppointmentView.animalsTableView.reloadData()
    }

    /// Show an alert with a title and a message
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return veterinarians.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return veterinarians[row].name
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectAnimalTableViewCell.reuseIdentifier, for: indexPath) as! SelectAnimalTableViewCell
        let animal = animals[indexPath.row]
        let isSelected = selectedAnimals.contains(where: { $0.id == animal.id })
        cell.configure(with: animal, isSelected: isSelected)
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let animal = animals[indexPath.row]
        if let indexToRemove = selectedAnimals.firstIndex(where: { $0.id == animal.id }) {
            selectedAnimals.remove(at: indexToRemove)
        } else {
            selectedAnimals.append(animal)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
