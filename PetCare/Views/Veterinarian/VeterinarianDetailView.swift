//
//  VeterinarianDetailView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class VeterinarianDetailView: UIView {
    
    // MARK: - Properties
    
    // Create a UIScrollView to allow scrolling when content is larger than the screen
    private let scrollView = UIScrollView()
    
    // Container view inside the scroll view
    private let containerView = UIView()
    
    // Labels for displaying veterinarian details
    private let nameLabel: UILabel = createLabel(font: .boldSystemFont(ofSize: 24), textColor: .label)
    private let addressLabel: UILabel = createLabel()
    private let phoneLabel: UILabel = createLabel()
    private let emailLabel: UILabel = createLabel()
    private let noteLabel: UILabel = createLabel()
    
    // Label for the appointments section
    private let appointmentsLabel: UILabel = {
        let label = createLabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = NSLocalizedString("next_appointments", comment: "")
        return label
    }()
    
    // Table view to display appointments
    private let appointmentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: AppointmentCell.reuseIdentifier)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // Label to display when there are no future appointments
    private let noAppointmentsLabel: UILabel = {
        let label = createLabel(font: .italicSystemFont(ofSize: 16), textColor: .secondaryLabel)
        label.text = NSLocalizedString("no_appointments", comment: "")
        label.isHidden = true
        return label
    }()
    
    // Veterinarian object to populate the view with details
    var veterinarian: Veterinarian? {
        didSet {
            populateDetails()
        }
    }
    
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
        // Add scroll view to the main view
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        // Set constraints for scroll view and container view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Create a vertical stack view to arrange all labels and the table view
        let stackView = UIStackView(arrangedSubviews: [
            createSectionView(title: "", content: nameLabel),
            createSectionView(title: NSLocalizedString("address", comment: ""), content: addressLabel),
            createSectionView(title: NSLocalizedString("phone", comment: ""), content: phoneLabel),
            createSectionView(title: NSLocalizedString("email", comment: ""), content: emailLabel),
            createSectionView(title: NSLocalizedString("note", comment: ""), content: noteLabel),
            appointmentsLabel,
            appointmentsTableView,
            noAppointmentsLabel
        ])
        
        // Configure stack view properties
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add stack view to container view
        containerView.addSubview(stackView)
        
        // Set constraints for stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            appointmentsTableView.heightAnchor.constraint(equalToConstant: 200) // Set a fixed height for the table view
        ])
        
        // Set data source and delegate for the table view
        appointmentsTableView.dataSource = self
        appointmentsTableView.delegate = self
    }
    
    // MARK: - Populate Details
    
    // Function to populate the view with veterinarian details
    private func populateDetails() {
        guard let veterinarian = veterinarian else { return }
        
        nameLabel.text = "Dr. " + veterinarian.name
        addressLabel.text = veterinarian.address + ", " + veterinarian.zipcode + ", " + veterinarian.city
        phoneLabel.text = veterinarian.phone ?? NSLocalizedString("No phone number available", comment: "")
        emailLabel.text = veterinarian.email ?? NSLocalizedString("No email available", comment: "")
        noteLabel.text = veterinarian.note ?? NSLocalizedString("No notes available", comment: "")
        
        if veterinarian.appointements?.isEmpty ?? true {
            noAppointmentsLabel.isHidden = false
            appointmentsTableView.isHidden = true
        } else {
            noAppointmentsLabel.isHidden = true
            appointmentsTableView.isHidden = false
        }
        
        appointmentsTableView.reloadData()
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
    
    // MARK: - Actions
    
    @objc private func callVeterinarian() {
        guard let phone = veterinarian?.phone, let url = URL(string: "tel://\(phone)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension VeterinarianDetailView: UITableViewDataSource, UITableViewDelegate {
    
    // Return the number of rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return veterinarian?.appointements?.count ?? 0
    }
    
    // Configure and return the cell for the row at the specified index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentCell.reuseIdentifier, for: indexPath) as! AppointmentCell
        if let appointment = veterinarian?.appointements?[indexPath.row] {
            cell.configure(with: appointment)
        }
        return cell
    }
}

// MARK: - AppointmentCell

class AppointmentCell: UITableViewCell {
    
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
