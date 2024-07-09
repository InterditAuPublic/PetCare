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
    private let animalsLabel: UILabel = createLabel(with: NSLocalizedString("Animals", comment: ""))
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
        
        dateLabel.text = NSLocalizedString("date: \(dateFormatter.string(from: appointment.date))", comment: "")
        descriptionLabel.text = NSLocalizedString("description:", comment: "") + (appointment.descriptionRdv ?? NSLocalizedString("no_description", comment: ""))
        veterinarianLabel.text = NSLocalizedString("veterinarian", comment: "") + " Dr. " + appointment.veterinarian.name
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
