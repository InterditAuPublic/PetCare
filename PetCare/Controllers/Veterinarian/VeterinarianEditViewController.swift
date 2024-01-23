//
//  VeterinarianEditViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class VeterinarianEditViewController: UIViewController {
    
    var veterinarianEditView: VeterinarianEditView?
    var veterinarian: Veterinarian?
    
    init(veterinarian: Veterinarian) {
        self.veterinarian = veterinarian
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = veterinarian?.name
        navigationItem.largeTitleDisplayMode = .never
        
        super.viewDidLoad()
        view.backgroundColor = .white

        veterinarianEditView = VeterinarianEditView(veterinarian: veterinarian)
        guard let veterinarianEditView = veterinarianEditView else { return }

        view.addSubview(veterinarianEditView)
        veterinarianEditView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            veterinarianEditView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            veterinarianEditView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            veterinarianEditView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            veterinarianEditView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        veterinarianEditView.veterinarianForm?.delegate = self

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    @objc private func saveButtonTapped() {
        
        guard let veterinarianForm = veterinarianEditView?.veterinarianForm else { return }
    
        let formFields = veterinarianForm.getFormFields()
        
        
        
        
        guard let name = formFields[1].value as? String, !name.isEmpty else {
            print("error name")
            return
        }
        
        guard let address = formFields[2].value as? String, !address.isEmpty else {
            print("error adree")
            return
        }
        
        guard let zipcode = formFields[3].value as? String, !zipcode.isEmpty else {
            print("error zip")
            return
        }
        
        guard let city = formFields[4].value as? String, !city.isEmpty else {
            print("error city")
            return
        }
        
        // guard let country = formFields[5].value as? String, !country.isEmpty else {
        //     return
        // }
        
        guard let phone = formFields[6].value as? String, !phone.isEmpty else {
            print("error phoe")
            return
        }
        
        guard let email = formFields[7].value as? String, !email.isEmpty else {
            print("error email")
            return
        }
        
        guard let note = formFields[7].value as? String, !note.isEmpty else {
            print("error Note")
            return
        }
        
        var veterinarianToSave = Veterinarian()

        veterinarianToSave.name = name
        veterinarianToSave.address = address
        veterinarianToSave.zipcode = zipcode
        veterinarianToSave.city = city
        // veterinarianToSave.country = country
        veterinarianToSave.phone = phone
        veterinarianToSave.email = email
//        
        if let veterinarian = veterinarian {
            veterinarianToSave.identifier = veterinarian.identifier
        }

        CoreDataManager.shared.updateVeterinarian(veterinarian: veterinarianToSave)

        // go back to the previous view controller
        navigationController?.popViewController(animated: true)
    }
}

extension VeterinarianEditViewController: FormDelegate {
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
    }
}
