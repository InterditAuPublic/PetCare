//
//  AppointmentTableViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 20/06/2024.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // UI Elements
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let petLabel = UILabel()
    private let vetLabel = UILabel()
    private let petImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Configure ImageView
        petImageView.contentMode = .scaleAspectFill
        petImageView.clipsToBounds = true
        petImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure Labels
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        petLabel.font = UIFont.systemFont(ofSize: 14)
        petLabel.translatesAutoresizingMaskIntoConstraints = false
        
        vetLabel.font = UIFont.systemFont(ofSize: 14)
        vetLabel.translatesAutoresizingMaskIntoConstraints = false

        // Add subviews
        contentView.addSubview(petImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(petLabel)
        contentView.addSubview(vetLabel)

        // Layout constraints
        NSLayoutConstraint.activate([
            petImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            petImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            petImageView.widthAnchor.constraint(equalToConstant: 50),
            petImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            petLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            petLabel.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 10),
            petLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            vetLabel.topAnchor.constraint(equalTo: petLabel.bottomAnchor, constant: 5),
            vetLabel.leadingAnchor.constraint(equalTo: petImageView.trailingAnchor, constant: 10),
            vetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            vetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with appointment: Appointment) {
        // Convert Date to String and display date and time
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .full
        let formattedDate = dateFormatter.string(from: appointment.date)
        
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: appointment.date)
        
        let dateTimeString = String(format: NSLocalizedString("%@ at %@", comment: ""), formattedDate, formattedTime)        
        titleLabel.text = dateTimeString
        descriptionLabel.text = appointment.descriptionRdv ?? "No description available"
        
        // Convert [Animal] to String
        let animalNames = appointment.animals.compactMap { $0.name }
        petLabel.text = String(format: NSLocalizedString("Pets: %@", comment: ""), animalNames.joined(separator: ", "))
        
        // Veterinarian name
        vetLabel.text = "Dr. " + appointment.veterinarian.name
        
        // Set Image (for now, using a placeholder as there's no specific image logic)
        petImageView.image = UIImage(named: "veterinary")
    }



}
