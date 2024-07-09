//
//  SelectAnimalTableViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 20/06/2024.
//

import UIKit

class SelectAnimalTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SelectAnimalTableViewCell"

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with animal: Animal, isSelected: Bool) {
        nameLabel.text = animal.name
        updateSelectionState(isSelected: isSelected, species: animal.species)
    }

    private func updateSelectionState(isSelected: Bool, species: Species?) {
        if isSelected {
            contentView.backgroundColor = UIColor.lightGray
        } else {
            contentView.backgroundColor = UIColor.white
        }

        // Set background color based on species
        if let species = species {
            switch species {
            case .dog:
                contentView.backgroundColor = isSelected ? UIColor.lightGray : UIColor(red: 0.9, green: 0.9, blue: 1.0, alpha: 1.0)
            case .cat:
                contentView.backgroundColor = isSelected ? UIColor.lightGray : UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0)
            }
        }
    }
}
