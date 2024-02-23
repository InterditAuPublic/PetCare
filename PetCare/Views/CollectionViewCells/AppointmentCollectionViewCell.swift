//
//  AppointmentCollectionViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 25/01/2024.
//

import UIKit

class AppointmentCollectionViewCell: UICollectionViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let petLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let vetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(petLabel)
        contentView.addSubview(vetLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])

        petLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            petLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            petLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])

        vetLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vetLabel.topAnchor.constraint(equalTo: petLabel.bottomAnchor, constant: 5),
            vetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            vetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            vetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }


    func configure(with appointment: Appointement) {
        titleLabel.text = "Appointment on"
        descriptionLabel.text = appointment.descriptionRdv
        
        // Convert Date to String
        if let date = appointment.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = "Date not available"
        }

        // Convert [Animal] to String
        if let animals = appointment.animals {
            let animalNames = animals.map { $0.name ?? "Unnamed Animal" }
            petLabel.text = "Pets: " + animalNames.joined(separator: ", ")
        } else {
            petLabel.text = "No pets specified"
        }

        // Convert Veterinarian to String
        if let veterinarian = appointment.veterinarian {
            vetLabel.text = "Veterinarian: \(veterinarian.name ?? "Unknown Veterinarian")"
        } else {
            vetLabel.text = "No veterinarian specified"
        }
    }

}
