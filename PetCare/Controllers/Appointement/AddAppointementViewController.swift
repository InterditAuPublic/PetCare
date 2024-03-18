//
//  AddAppointementViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 17/03/2024.
//

import UIKit
import CoreData

class AddAppointmentViewController: UIViewController {
    
    // MARK: - Properties
    
    private var appointmentForm: AppointmentForm!
    var veterinarians: [Veterinarian]?
    var animals: [Animal]?
    
    // Inject CoreData context
    var context: NSManagedObjectContext!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupAppointmentForm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchVeterinarians()
        fetchAnimals()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAppointment))
    }
    
    private func setupAppointmentForm() {
        // Fetch veterinarians and animals from CoreData
        fetchVeterinarians()
        fetchAnimals()
        
        // Initialize the appointment form with fetched data
        appointmentForm = AppointmentForm(appointment: nil, veterinarians: veterinarians ?? [], animals: animals ?? [])

        // Add the appointment form to the view
        view.addSubview(appointmentForm)

        // Set up constraints for the appointment form
        appointmentForm.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appointmentForm.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appointmentForm.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appointmentForm.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            appointmentForm.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // Set the delegate of the text field to the view controller
        appointmentForm.delegate = self

    }
    
    // MARK: - CoreData Fetching
    
    private func fetchVeterinarians() {
        if let fetchedVeterinarians = CoreDataManager.shared.fetchVeterinarians() {
            veterinarians = fetchedVeterinarians
        }
    }
    
    private func fetchAnimals() {
        if let fetchedAnimals = CoreDataManager.shared.fetchAnimals() {
            animals = fetchedAnimals
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func saveAppointment() {
        guard let appointmentForm = appointmentForm,
              let formFields = appointmentForm.getFormFields() as? [FormField],
              formFields.count >= 4 else {
            showAlert(title: "Error", message: "Appointment form data is incomplete.")
            return
        }
        
        // Validate date
        guard let date = formFields[0].value as? Date else {
            showAlert(title: "Error", message: NSLocalizedString("date_validation_message", comment: ""))
            return
        }
        
        // Validate veterinarian
        guard let veterinarianIndex = formFields[1].value as? Int, veterinarianIndex < (veterinarians?.count ?? 0) else {
            showAlert(title: "Error", message: NSLocalizedString("veterinarian_validation_message", comment: ""))
            return
        }
        
        // Validate animals
        guard let animalIndexes = formFields[2].value as? [Int] else {
            showAlert(title: "Error", message: NSLocalizedString("animal_validation_message", comment: ""))
            return
        }
        
        var selectedAnimals: [Animal] = []
        for index in animalIndexes {
            if let animals = animals, index < animals.count {
                selectedAnimals.append(animals[index])
            } else {
                showAlert(title: "Error", message: NSLocalizedString("animal_validation_message", comment: ""))
                return
            }
        }
        
        // Validate description
        guard let description = formFields[3].value as? String, !description.isEmpty else {
            showAlert(title: "Error", message: NSLocalizedString("description_validation_message", comment: ""))
            return
        }
        
        guard let veterinarian = veterinarians?[veterinarianIndex] else {
            showAlert(title: "Error", message: "Selected veterinarian not found.")
            return
        }
        
        let appointment = Appointement(id: "0", date: date, descriptionRdv: description, animals: selectedAnimals, veterinarian: veterinarian)
        
        // Save the appointment to the database
        CoreDataManager.shared.saveAppointement(appointement: appointment)
        
        // Dismiss the view controller after saving the appointment
        navigationController?.popViewController(animated: true)
    }


        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
}
