//
//  VeterinaryAppointmentTableViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 10/07/2024.
//

import UIKit

class VeterinaryAppointmentTableViewCell: UITableViewCell {
    
    // Reuse identifier for the cell
    static let reuseIdentifier = "AppointmentCell"
    
    // Labels to display appointment details
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        // Create a stack view to arrange the labels
        let stackView = UIStackView(arrangedSubviews: [dateLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add stack view to the cell's content view
        contentView.addSubview(stackView)
        
        // Set constraints for stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure Cell
    
    // Method to configure the cell with appointment details
    func configure(with appointment: Appointment) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        dateLabel.text = dateFormatter.string(from: appointment.date)
        descriptionLabel.text = appointment.descriptionRdv
    }
}
