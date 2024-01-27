//
//  AppointementViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit
import CoreData

class AppointementViewController: UIViewController {
    
    // Core Data context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data arrays for veterinarians and animals (for testing purposes)
    var veterinarians: [Veterinarian] = []
    var animals: [Animal] = []
    
    // Selected veterinarian and animals for the appointment
    var selectedVeterinarian: Veterinarian?
    var selectedAnimals: [Animal] = []
    
    // Date picker
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return picker
    }()
    
    // UI components
    let veterinarianPickerView = UIPickerView()
    let animalsTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchVeterinarians()
        fetchAnimals()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animalsTableView.register(AnimalTableViewCell.self, forCellReuseIdentifier: "animalCell")
        setupUI()
        fetchVeterinarians()
        fetchAnimals()
    }
    
    func setupUI() {
        // Add veterinarianPickerView
            view.addSubview(veterinarianPickerView)
            veterinarianPickerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                veterinarianPickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                veterinarianPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                veterinarianPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                veterinarianPickerView.heightAnchor.constraint(equalToConstant: 150)
            ])
            
            // Add animalsTableView
            view.addSubview(animalsTableView)
            animalsTableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animalsTableView.topAnchor.constraint(equalTo: veterinarianPickerView.bottomAnchor, constant: 20),
                animalsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                animalsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                animalsTableView.heightAnchor.constraint(equalToConstant: 200)
            ])
            
            // Add date picker if needed
            view.addSubview(datePicker)
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                datePicker.topAnchor.constraint(equalTo: animalsTableView.bottomAnchor, constant: 20),
                datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
            
            // Add a button to create an appointment
            let createAppointmentButton = UIButton(type: .system)
            createAppointmentButton.setTitle("Create Appointment", for: .normal)
            createAppointmentButton.addTarget(self, action: #selector(createAppointment), for: .touchUpInside)
            view.addSubview(createAppointmentButton)
            createAppointmentButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                createAppointmentButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
                createAppointmentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

        veterinarianPickerView.delegate = self
        veterinarianPickerView.dataSource = self
        
        animalsTableView.delegate = self
        animalsTableView.dataSource = self
    }
    
    private func fetchVeterinarians() {
        if let fetchedVeterinarians = CoreDataManager.shared.fetchVeterinarians() {
            veterinarians = fetchedVeterinarians
            print(veterinarians)
        }
    }
    
    private func fetchAnimals() {
        if let fetchedAnimals = CoreDataManager.shared.fetchAnimals() {
            animals = fetchedAnimals
            print(animals)
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Handle date picker value changed event
        let selectedDate = sender.date
        // Use the selected date as needed
    }
    
    @objc func createAppointment() {
        
        print("create")
        // Create a new appointment using the selected veterinarian, animals, date, and other details
        guard let veterinarian = selectedVeterinarian, !selectedAnimals.isEmpty else {
            
            print("guard failed")// Display an alert indicating that a veterinarian and at least one animal must be selected
            return
        }
        print("create new appointement")
        var newAppointment = Appointement()
        newAppointment.date = datePicker.date
        // Set other details for the appointment
        newAppointment.animals = selectedAnimals
        newAppointment.veterinarian = veterinarian
        
        print("save new appointement")
        CoreDataManager.shared.saveAppointement(appointement: newAppointment)
    }
}

extension AppointementViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return veterinarians.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return veterinarians[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedVeterinarian = veterinarians[row]
    }
}

extension AppointementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath) as! AnimalTableViewCell
        let animal = animals[indexPath.row]
        // Configure the cell with the animal details
        cell.configure(with: animal)
        // Add any other details as needed
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnimal = animals[indexPath.row]
        
        // Check if the selected animal is already in the list
        if selectedAnimals.contains(where: { $0.id == selectedAnimal.id }) {
            // If yes, remove it
            selectedAnimals.removeAll { $0.id == selectedAnimal.id }
        } else {
            // If not, add it
            selectedAnimals.append(selectedAnimal)
        }
        
        // Reload the selected row to update the UI
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

