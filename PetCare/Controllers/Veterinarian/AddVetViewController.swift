//
//  AddVetViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/01/2024.
//

import UIKit

class AddVetViewController: UIViewController, UIGestureRecognizerDelegate, FormDelegate {
    
    let addVetView = AddVeterinarianView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        configureNavigationBar()
        setupTapGesture()
        setupUI()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .orange
    }
    
    private func setupUI() {
        setupAddVetView()
        setupKeyboardNotifications()
    }
    
    private func setupAddVetView() {
        view.addSubview(addVetView)
        //        addVetView.vetDelegate = self
        addVetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addVetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addVetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addVetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addVetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        addVetView.VetForm.delegate = self
        
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonTapped() {
        let formFields = addVetView.VetForm.getFormFields()
        
        var veterinarianToSave = Veterinarian()
        veterinarianToSave.name = formFields[1].value as? String
        veterinarianToSave.address = formFields[2].value as? String
        veterinarianToSave.zipcode = formFields[3].value as? String
        veterinarianToSave.city = formFields[4].value as? String
        veterinarianToSave.country = formFields[5].value as? String
        veterinarianToSave.phone = formFields[6].value as? String
        veterinarianToSave.email = formFields[7].value as? String
        veterinarianToSave.note = formFields[8].value as? String
        
        // save the vet to the database
        CoreDataManager.shared.saveVeterinarian(veterinarian: veterinarianToSave)
        
    }
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        
    }
    
    
    //MARK: Keyboard
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        addVetView.contentInset = contentInsets
        addVetView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide() {
        let contentInsets = UIEdgeInsets.zero
        addVetView.contentInset = contentInsets
        addVetView.scrollIndicatorInsets = contentInsets
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
}
