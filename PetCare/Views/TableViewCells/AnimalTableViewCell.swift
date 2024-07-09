//
//  AnimalTableViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 11/01/2024.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "AnimalTableViewCell"
    
    private let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 26
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
 
    private let borderView: UIView = {
        // Add a second border
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.cornerRadius = 30 // Larger corner radius to accommodate the first border
        borderView.layer.borderWidth = 2 // Border width
        borderView.layer.borderColor = UIColor.orange.cgColor // Border color
        borderView.layer.shadowColor = UIColor.red.cgColor
        borderView.layer.opacity = 1
        borderView.layer.shadowOffset = CGSize(width: 3, height: 3)
        return borderView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        borderView.addSubview(animalImageView)
        contentView.addSubview(borderView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailsLabel)
        
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            borderView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            borderView.widthAnchor.constraint(equalToConstant: 60),
            borderView.heightAnchor.constraint(equalToConstant: 60),
            
            animalImageView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 4),
            animalImageView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 4),
            animalImageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -4),
            animalImageView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -4),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            detailsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            detailsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            detailsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    func configure(with animal: Animal) {
        nameLabel.text = animal.name
        detailsLabel.text = animal.breed
        
        let defaultImage: String
        if animal.species == .dog {
            defaultImage = "dog_default_image"
        } else {
            defaultImage = "cat_default_image"
        }

        // Utilize the animal's image if available, otherwise use the default image
        if let imageData = animal.image, let image = UIImage(data: imageData) {
            animalImageView.image = image
        } else {
            animalImageView.image = UIImage(named: defaultImage)
        }
    }
}

