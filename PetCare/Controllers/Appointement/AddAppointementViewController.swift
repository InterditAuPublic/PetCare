//
//  AddAppointementViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 17/03/2024.
//

import UIKit
import CoreData
import FirebaseAnalytics

class AddAppointmentViewController: UIViewController, UIScrollViewDelegate, FormDelegate {
    
    
    // MARK: - Properties
    
    private var appointmentForm: AddAppointementView?
    var veterinarians: [Veterinarian]?
    var animals: [Animal]?
    var appointement: Appointement?
    // Inject CoreData context
    var context: NSManagedObjectContext!
 
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        appointmentForm = AddAppointementView(appointment: appointement, veterinarians: veterinarians!, animals: animals ?? [])

        // Add the appointment form to the view
        view.addSubview(appointmentForm!)

        // Set up constraints for the appointment form
        appointmentForm!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appointmentForm!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appointmentForm!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appointmentForm!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            appointmentForm!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        // Set the delegate of the text field to the view controller
        appointmentForm!.delegate = self

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
        guard let appointmentForm = appointmentForm else {
            return
        }

        let values = appointmentForm.AppointementForm.getFormValues()
        print("Form values: \(values)")


        let formFields = appointmentForm.AppointementForm.getFormFields()
        
        for field in formFields {
            print("Field: \(field.labelText) - Value: \(field.value ?? "nil")")
        }

        // Check if all fields are filled
        for field in formFields {
            if field.value == nil {
                showAlert(title: NSLocalizedString("error", comment: ""), message: NSLocalizedString("fill_all_fields", comment: ""))
                return
            }
        }

        // Create an appointment object with the form values
        var appointment = Appointement()
        appointment.id = UUID().uuidString
        appointment.date = formFields[0].value as? Date
        appointment.descriptionRdv = formFields[3].value as? String

        // Handling the Animal array
        if let selectedAnimals = formFields[1].value as? [Animal] {
            appointment.animals = selectedAnimals
        }

        // Handling the Veterinarian
        if let selectedVet = formFields[2].value as? Veterinarian {
     
            appointment.veterinarian = selectedVet
        }

        // Display all the appointment details 
        print(appointment)

        // Save the appointment to CoreData
        CoreDataManager.shared.saveAppointement(appointement: appointment)

        // Recording the event of adding an appointment
        Analytics.logEvent("appointment_added", parameters: nil)

        // Dismiss the view controller after saving the appointment
        navigationController?.popViewController(animated: true)
    }

        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    
    func formDidUpdateValue(_ value: Any?, forField field: any FormField) {
        switch field {
        case let dateField as DateFormField:
            appointement?.date = value as? Date
        case let veterinarianField as PickerFormField:
            if let selectedVetName = value as? String {
                appointement?.veterinarian = veterinarians?.first { $0.name == selectedVetName }
                // Log the selected veterinarian name
                print("Selected veterinarian name: \(selectedVetName)")
            }
        case let animalsField as PickerFormField:
            if let selectedAnimalNames = value as? [String] {
                appointement?.animals = animals?.filter { selectedAnimalNames.contains($0.name ?? "") }
                // Log the selected animals names
                print("Selected animals names: \(selectedAnimalNames)")
            }
        case let descriptionField as TextFormField:
            appointement?.descriptionRdv = value as? String
        default:
            break
        }
    }
}
