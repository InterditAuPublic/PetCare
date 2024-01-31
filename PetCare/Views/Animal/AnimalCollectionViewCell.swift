//
//  AnimalCollectionViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 27/01/2024.
//
import UIKit

// Step 1: Define the AnimalCellDelegate protocol
protocol AnimalCellDelegate: AnyObject {
    func didTap()
}

class AnimalCollectionViewCell: UICollectionViewCell {
    
    // Step 2: Add a weak delegate property
    weak var delegate: AnimalCellDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        // Add tap gesture recognizer to the cell
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])

        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // Step 4: Call delegate method on cell tap
    @objc private func cellTapped() {
        print("cell tapped")
        delegate?.didTap()
    }

    func configure(with animal: Animal) {
        let defaultImage: UIImage
        if animal.species?.rawValue == "Dog" {
            defaultImage = UIImage(named: "dog_default_image") ?? UIImage()
        } else {
            defaultImage = UIImage(named: "cat_default_image") ?? UIImage()
        }

        imageView.image = defaultImage
        nameLabel.text = animal.name
    }
}
