//
//  VeterinarianEditView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class VeterinarianEditView: UIScrollView {

    
    var veterinarianForm: VeterinarianForm?
    
    init(veterinarian: Veterinarian?) {
        super.init(frame: .zero)
        veterinarianForm = VeterinarianForm(veterinarian: veterinarian)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let veterinarianForm = veterinarianForm else { return }
        addSubview(veterinarianForm)
        
        // Venter the form in the scroll view
        veterinarianForm.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        // Set up constraints for VeterinarianForm
        NSLayoutConstraint.activate([
            veterinarianForm.topAnchor.constraint(equalTo: topAnchor),
            veterinarianForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            veterinarianForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            veterinarianForm.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
        ])
        
        veterinarianForm.translatesAutoresizingMaskIntoConstraints = false
    }

}
