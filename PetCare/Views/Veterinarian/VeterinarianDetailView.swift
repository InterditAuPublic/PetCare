//
//  VeterinarianDetailView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class VeterinarianDetailView: UIView {
    
    var veterinarian: Veterinarian?
    
    init(veterinarian: Veterinarian) {
        self.veterinarian = veterinarian
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        guard let veterinarian = veterinarian else { return }
        
        
        // Create a great looking detail view for the veterinarian
        
        let nameLabel = UILabel()
        nameLabel.text = veterinarian.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        let addressLabel = UILabel()
        addressLabel.text = veterinarian.address
        addressLabel.font = UIFont.systemFont(ofSize: 16)
        addressLabel.textColor = .white
        addressLabel.textAlignment = .center
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = veterinarian.phone
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 16)
        phoneNumberLabel.textColor = .white
        phoneNumberLabel.textAlignment = .center
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneNumberLabel)
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
