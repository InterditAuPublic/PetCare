//
//  VeterinarianEditViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class VeterinarianEditViewController: UIViewController, FormDelegate {
    
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
        view.backgroundColor = .systemIndigo
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = veterinarian?.name
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
        
    }
    
    func setupUI() {
        guard let veterinarian = veterinarian else { return }
        let veterinarianEditView = VeterinarianEditView(veterinarian: veterinarian)
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
        
        print(formFields)
    }
    
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        
    }
}
