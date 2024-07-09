//
//  AddAppointmentViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 17/03/2024.
//

import UIKit
import FirebaseAnalytics

class AddAppointmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    let addAppointmentView = AppointmentView()
    var veterinarians: [Veterinarian] = []
    var animals: [Animal] = []
    var selectedAnimals: [Animal] = []

    override func loadView() {
        view = addAppointmentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("add_appointment_title", comment: "")
        view.backgroundColor = .white

        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAppointment))
        navigationItem.rightBarButtonItem = addButton

        // Load veterinarians and animals from CoreData or other source
        loadVeterinarians()
        loadAnimals()

        addAppointmentView.veterinarianPicker.delegate = self
        addAppointmentView.veterinarianPicker.dataSource = self
        addAppointmentView.animalsTableView.delegate = self
        addAppointmentView.animalsTableView.dataSource = self

        // Register the table view cell
        addAppointmentView.animalsTableView.register(SelectAnimalTableViewCell.self, forCellReuseIdentifier: SelectAnimalTableViewCell.reuseIdentifier)
    }

    @objc private func saveAppointment() {
        guard let selectedVeterinarianIndex = addAppointmentView.veterinarianPicker.selectedRow(inComponent: 0) as Int?,
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

        let appointmentForm = AppointmentForm(
            id: UUID().uuidString,
            date: addAppointmentView.datePicker.date,
            descriptionRdv: addAppointmentView.descriptionTextField.text,
            veterinarian: selectedVeterinarian,
            animals: selectedAnimals
        )

        CoreDataManager.shared.saveAppointment(form: appointmentForm)
        
        Analytics.logEvent("appointment_created", parameters: [
            "animal_count": selectedAnimals.count,
            "date": addAppointmentView.datePicker.date.timeIntervalSince1970
        ])

        navigationController?.popViewController(animated: true)
    }

    private func loadVeterinarians() {
        // Load veterinarians from CoreData or other source
        veterinarians = CoreDataManager.shared.fetchVeterinarians() ?? []
        addAppointmentView.veterinarianPicker.reloadAllComponents()
    }

    private func loadAnimals() {
        // Load animals from CoreData or other source
        animals = CoreDataManager.shared.fetchAnimals() ?? []
        addAppointmentView.animalsTableView.reloadData()
    }

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
        if pickerView == addAppointmentView.veterinarianPicker {
            return veterinarians.count
        }
        return 0
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == addAppointmentView.veterinarianPicker {
            return veterinarians[row].name
        }
        return nil
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
