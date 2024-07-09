//
//  AppointmentCollectionViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/02/2024.
//
//

import UIKit

class AppointmentCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var containerView: UIView!
    private var timeContainerView: UIStackView!
    private var calendarIconImageView: UIImageView!
    private var clockIconImageView: UIImageView!
    private var dateLabel: UILabel!
    private var timeLabel: UILabel!
    private var vetInfoContainerView: UIView!
    private var vetInfoLabel: UILabel!
    private var vetAddressLabel: UILabel!
    private var animalsContainerView: UIView!
    private var animalsLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var topSectionView: UIView!
    private var middleSectionView: UIView!
    private var bottomSectionView: UIView!
    private var separatorView1: UIView!
    private var separatorView2: UIView!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        setupContainerView()
        setupTimeContainerView()
        setupVetInfoContainerView()
        setupAnimalsContainerView()
    }
    
    private func setupContainerView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowRadius = 4
        
        containerView.layer.borderWidth = 1
        
        topSectionView = createSectionView(with: .orange)
        middleSectionView = createSectionView(with: .white)
        bottomSectionView = createSectionView(with: .white)
        
        containerView.addSubview(topSectionView)
        containerView.addSubview(middleSectionView)
        containerView.addSubview(bottomSectionView)
        
        separatorView1 = createSeparatorView()
        separatorView2 = createSeparatorView()
        
        containerView.addSubview(separatorView1)
        containerView.addSubview(separatorView2)
        
        NSLayoutConstraint.activate([
            topSectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            topSectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topSectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topSectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.2),
            
            separatorView1.topAnchor.constraint(equalTo: topSectionView.bottomAnchor),
            separatorView1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorView1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorView1.heightAnchor.constraint(equalToConstant: 1),
            
            middleSectionView.topAnchor.constraint(equalTo: separatorView1.bottomAnchor),
            middleSectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            middleSectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            middleSectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.6),
            
            separatorView2.topAnchor.constraint(equalTo: middleSectionView.bottomAnchor),
            separatorView2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorView2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorView2.heightAnchor.constraint(equalToConstant: 1),
            
            bottomSectionView.topAnchor.constraint(equalTo: separatorView2.bottomAnchor),
            bottomSectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomSectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomSectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        topSectionView.layer.cornerRadius = 10
        topSectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomSectionView.layer.cornerRadius = 10
        bottomSectionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    private func createSectionView(with color: UIColor) -> UIView {
        let sectionView = UIView()
        sectionView.translatesAutoresizingMaskIntoConstraints = false
        sectionView.backgroundColor = color
        return sectionView
    }
    
    private func createSeparatorView() -> UIView {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .orange
        return separatorView
    }
    
    private func setupTimeContainerView() {
        calendarIconImageView = UIImageView(image: UIImage(systemName: "calendar"))
        calendarIconImageView.contentMode = .scaleAspectFit
        clockIconImageView = UIImageView(image: UIImage(systemName: "clock"))
        clockIconImageView.contentMode = .scaleAspectFit
        dateLabel = UILabel()
        timeLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .white
        timeLabel.textColor = .white
        clockIconImageView.tintColor = .white
        calendarIconImageView.tintColor = .white
        
        let calendarStackView = UIStackView(arrangedSubviews: [calendarIconImageView, dateLabel])
        calendarStackView.axis = .horizontal
        calendarStackView.spacing = 4
        
        let clockStackView = UIStackView(arrangedSubviews: [clockIconImageView, timeLabel])
        clockStackView.axis = .horizontal
        clockStackView.spacing = 4
        
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        timeContainerView = UIStackView(arrangedSubviews: [calendarStackView, clockStackView, spacerView])
        timeContainerView.translatesAutoresizingMaskIntoConstraints = false
        timeContainerView.axis = .horizontal
        timeContainerView.spacing = 10
        containerView.addSubview(timeContainerView)
        
        NSLayoutConstraint.activate([
            timeContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            timeContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            timeContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupVetInfoContainerView() {
        // Create vetInfoContainerView
        vetInfoContainerView = UIView()
        vetInfoContainerView.translatesAutoresizingMaskIntoConstraints = false
        middleSectionView.addSubview(vetInfoContainerView)
        
        // Apply layout constraints to vetInfoContainerView
        NSLayoutConstraint.activate([
            vetInfoContainerView.topAnchor.constraint(equalTo: middleSectionView.topAnchor, constant: 10),
            vetInfoContainerView.leadingAnchor.constraint(equalTo: middleSectionView.leadingAnchor, constant: 10),
            vetInfoContainerView.trailingAnchor.constraint(equalTo: middleSectionView.trailingAnchor, constant: -10),
            vetInfoContainerView.bottomAnchor.constraint(equalTo: middleSectionView.bottomAnchor, constant: -10)
        ])
        
        // Create and configure labels
        vetInfoLabel = UILabel()
        configureLabel(vetInfoLabel, font: .boldSystemFont(ofSize: 15), textColor: .black)
        
        vetAddressLabel = UILabel()
        configureLabel(vetAddressLabel, font: .systemFont(ofSize: 14), textColor: .black)
        
        descriptionLabel = UILabel()
        configureLabel(descriptionLabel, font: .systemFont(ofSize: 14), textColor: .lightGray)
        
        // Create stack view with labels
        let vetStackView = UIStackView(arrangedSubviews: [vetInfoLabel, vetAddressLabel, descriptionLabel])
        vetStackView.axis = .vertical
        vetStackView.spacing = 4  // Assurez-vous que le spacing est uniforme
        vetStackView.translatesAutoresizingMaskIntoConstraints = false
        vetInfoContainerView.addSubview(vetStackView)
        
        // Apply layout constraints to stack view
        NSLayoutConstraint.activate([
            vetStackView.topAnchor.constraint(equalTo: vetInfoContainerView.topAnchor),
            vetStackView.leadingAnchor.constraint(equalTo: vetInfoContainerView.leadingAnchor),
            vetStackView.trailingAnchor.constraint(equalTo: vetInfoContainerView.trailingAnchor),
            vetStackView.bottomAnchor.constraint(equalTo: vetInfoContainerView.bottomAnchor)
        ])
    }

    private func configureLabel(_ label: UILabel, font: UIFont, textColor: UIColor) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = textColor
        label.font = font
        label.numberOfLines = 0
    }
    private func setupAnimalsContainerView() {
        animalsContainerView = UIView()
        animalsContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomSectionView.addSubview(animalsContainerView)
        
        NSLayoutConstraint.activate([
            animalsContainerView.topAnchor.constraint(equalTo: bottomSectionView.topAnchor, constant: 10),
            animalsContainerView.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 10),
            animalsContainerView.trailingAnchor.constraint(equalTo: bottomSectionView.trailingAnchor, constant: -10)
        ])
        
        animalsLabel = UILabel()
        animalsLabel.translatesAutoresizingMaskIntoConstraints = false
        animalsLabel.textAlignment = .left
        animalsLabel.textColor = .black
        animalsLabel.font = UIFont.systemFont(ofSize: 14)
        animalsLabel.numberOfLines = 0
        animalsContainerView.addSubview(animalsLabel)
        
        NSLayoutConstraint.activate([
            animalsLabel.topAnchor.constraint(equalTo: animalsContainerView.topAnchor),
            animalsLabel.leadingAnchor.constraint(equalTo: animalsContainerView.leadingAnchor),
            animalsLabel.trailingAnchor.constraint(equalTo: animalsContainerView.trailingAnchor),
            animalsLabel.bottomAnchor.constraint(equalTo: animalsContainerView.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    func setup(_ appointment: Appointment) {
        configureDateTime(appointment.date)
        configureVetInfo(appointment.veterinarian)
        configureAnimals(appointment.animals)
        configureDescription(appointment.descriptionRdv)
    }
    
    private func configureDateTime(_ date: Date) {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .full
        let formattedDate = dateFormatter.string(from: date)
        dateLabel.text = formattedDate
        
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: date)
        timeLabel.text = formattedTime
        
        if dateIsInPast(date) {
            setPastAppointmentColors()
        } else {
            setFutureAppointmentColors()
        }
    }
    
    private func dateIsInPast(_ date: Date) -> Bool {
        return date < Date()
    }
    
    private func setPastAppointmentColors() {
        containerView.layer.borderColor = UIColor.gray.cgColor
        topSectionView.backgroundColor = .gray
        separatorView1.backgroundColor = .gray
        separatorView2.backgroundColor = .gray
    }
    
    private func setFutureAppointmentColors() {
        containerView.layer.borderColor = UIColor.orange.cgColor
        topSectionView.backgroundColor = .orange
        separatorView1.backgroundColor = .orange
        separatorView2.backgroundColor = .orange
    }
    
    private func configureVetInfo(_ veterinarian: Veterinarian) {
       
        vetInfoLabel.text = "Dr. " + veterinarian.name
        let address = [veterinarian.address, veterinarian.zipcode, veterinarian.city].compactMap { $0 }.joined(separator: ", ")
        vetAddressLabel.text = address
    }
    
    private func configureAnimals(_ animals: [Animal]?) {
        guard let animals = animals else {
            animalsLabel.text = NSLocalizedString("Animals: No animals assigned", comment: "")
            return
        }
        
        let animalNames = animals.compactMap { $0.name }
        let animalsString = animalNames.joined(separator: ", ")
        animalsLabel.text = NSLocalizedString("Animals: ", comment: "") + animalsString
    }
    
    private func configureDescription(_ description: String?) {
        descriptionLabel.text = description
    }
}
