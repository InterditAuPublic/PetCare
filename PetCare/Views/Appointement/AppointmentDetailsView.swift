//
//  AppointmentDetailsView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 20/06/2024.
//

import UIKit

class AppointmentDetailsView: UIScrollView {
    
    // MARK: - Properties
    private let dateCardView: UIView = createCardView()
    private let descriptionCardView: UIView = createCardView()
    private let veterinarianCardView: UIView = createCardView()
    private let animalsCardView: UIView = createCardView()
    
    private let dateLabel: UILabel = createLabel()
    private let descriptionLabel: UILabel = createLabel()
    private let veterinarianLabel: UILabel = createLabel()
    private let animalsLabel: UILabel = createLabel(with: "Animals")
    private let animalsTableView: UITableView = createTableView()
    
    var animals: [Animal] = [] {
        didSet {
            animalsTableView.reloadData()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .systemGroupedBackground
        
        let stackView = UIStackView(arrangedSubviews: [
            createCardView(with: dateCardView, and: dateLabel),
            createCardView(with: descriptionCardView, and: descriptionLabel),
            createCardView(with: veterinarianCardView, and: veterinarianLabel),
            createCardView(with: animalsCardView, and: animalsLabel, and: animalsTableView)
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40)
        ])
        
        // Adding a height constraint for the animalsTableView to make sure it appears correctly
        animalsTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        animalsTableView.dataSource = self
        animalsTableView.delegate = self
        animalsTableView.register(AnimalTableViewCell.self, forCellReuseIdentifier: AnimalTableViewCell.reuseIdentifier)
    }
    
    private static func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }
    
    private static func createLabel(with text: String) -> UILabel {
        let label = createLabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    
    private static func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
        return tableView
    }
    
    private static func createCardView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }
    
    private func createCardView(with contentView: UIView, and label: UILabel, and tableView: UITableView? = nil) -> UIView {
        let cardView = contentView
        cardView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
        ])
        
        if let tableView = tableView {
            cardView.addSubview(tableView)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
                tableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
                tableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
                tableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
            ])
        } else {
            NSLayoutConstraint.activate([
                label.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
            ])
        }
        
        return cardView
    }
    
    // MARK: - Public Methods
    func configure(with appointment: Appointment) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        dateLabel.text = "Date: \(dateFormatter.string(from: appointment.date))"
        descriptionLabel.text = "Description: \(appointment.descriptionRdv ?? "N/A")"
        veterinarianLabel.text = "Veterinarian: \(appointment.veterinarian.name ?? "N/A")"
        animals = appointment.animals
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension AppointmentDetailsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimalTableViewCell.reuseIdentifier, for: indexPath) as! AnimalTableViewCell
        let animal = animals[indexPath.row]
        cell.configure(with: animal)
        return cell
    }
}


import UIKit

class AppointmentDetailView: UIView {
    
    // MARK: - Properties
    
    // Labels for displaying appointment details
    private let titleLabel: UILabel = createLabel(font: .boldSystemFont(ofSize: 24), textColor: .label)
    private let descriptionLabel: UILabel = createLabel()
    private let animalsLabel: UILabel = createLabel()
    private let veterinarianNameLabel: UILabel = createLabel()
    private let veterinarianAddressLabel: UILabel = createLabel()
    private let veterinarianPhoneLabel: UILabel = createLabel()
    private let veterinarianEmailLabel: UILabel = createLabel()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        // Create a vertical stack view to arrange all labels
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            createSectionView(title: NSLocalizedString("Description", comment: ""), content: descriptionLabel),
            createSectionView(title: NSLocalizedString("Animals", comment: ""), content: animalsLabel),
            createSectionView(title: NSLocalizedString("Veterinarian Name", comment: ""), content: veterinarianNameLabel),
            createSectionView(title: NSLocalizedString("Veterinarian Address", comment: ""), content: veterinarianAddressLabel),
            createSectionView(title: NSLocalizedString("Veterinarian Phone", comment: ""), content: veterinarianPhoneLabel),
            createSectionView(title: NSLocalizedString("Veterinarian Email", comment: ""), content: veterinarianEmailLabel)
        ])
        
        // Configure stack view properties
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add stack view to main view
        addSubview(stackView)
        
        // Set constraints for stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Populate Details
    
    // Function to populate the view with appointment details
    func configure(with appointment: Appointment) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        titleLabel.text = dateFormatter.string(from: appointment.date)
        descriptionLabel.text = appointment.descriptionRdv ?? NSLocalizedString("no_description_available", comment: "")
        animalsLabel.text = appointment.animals.map { $0.name }.joined(separator: ", ")
        veterinarianNameLabel.text = "Dr. " + (appointment.veterinarian.name ?? NSLocalizedString("no_name_available", comment: ""))
        veterinarianAddressLabel.text = "\(appointment.veterinarian.address ?? NSLocalizedString("no_address_available", comment: "")), \(appointment.veterinarian.zipcode ?? NSLocalizedString("no_zipcode_available", comment: "")), \(appointment.veterinarian.city ?? NSLocalizedString("no_city_available", comment: ""))"
        veterinarianPhoneLabel.text = appointment.veterinarian.phone ?? NSLocalizedString("no_phone_number_available", comment: "")
        veterinarianEmailLabel.text = appointment.veterinarian.email ?? NSLocalizedString("no_email_available", comment: "")
    }
    
    // MARK: - Factory Methods
    
    // Factory method to create and configure UILabels
    private static func createLabel(font: UIFont = .systemFont(ofSize: 16), textColor: UIColor = .secondaryLabel) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // Factory method to create section views with title and content
    private func createSectionView(title: String, content: UIView) -> UIView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, content])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let sectionView = UIView()
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        sectionView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: sectionView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: sectionView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: sectionView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor)
        ])
        
        return sectionView
    }
}
