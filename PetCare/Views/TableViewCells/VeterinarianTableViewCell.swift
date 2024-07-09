//
//  VeterinarianTableViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/01/2024.
//

import UIKit

class VeterinarianTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "VeterinarianTableViewCell"
    
    let veterinarianImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "veterinary")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(veterinarianImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        
        // Contraintes pour l'image
        NSLayoutConstraint.activate([
            veterinarianImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            veterinarianImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            veterinarianImageView.widthAnchor.constraint(equalToConstant: 50),
            veterinarianImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Contraintes pour le nom
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: veterinarianImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        // Contraintes pour l'adresse
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: veterinarianImageView.trailingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with veterinarian: Veterinarian) {
        nameLabel.text = "Dr. " + veterinarian.name
        addressLabel.text = veterinarian.address + ", " + veterinarian.zipcode + ", " + veterinarian.city
    }
}

