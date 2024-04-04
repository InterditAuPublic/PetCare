//
//  AddAppointmentView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/03/2024.
//

import Foundation
import UIKit

class AddAppointementView: UIScrollView, UITextFieldDelegate {
    
    var AppointementForm: AppointmentForm!
    // MARK: - Properties
    
    init(appointment: Appointement?, veterinarians: [Veterinarian], animals: [Animal]) {
        super.init(frame: .zero)
        AppointementForm = AppointmentForm(appointment: appointment, veterinarians: veterinarians, animals: animals)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(AppointementForm)
        
        // Center the form in the scroll view
        AppointementForm.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // Set up constraints for AnimalForm
        NSLayoutConstraint.activate([
            AppointementForm.topAnchor.constraint(equalTo: topAnchor),
            AppointementForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            AppointementForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            AppointementForm.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        
        AppointementForm.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
