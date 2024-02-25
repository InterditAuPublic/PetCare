//
//  AppointementCollectionViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/02/2024.
//
//
import UIKit

class AppointementCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var containerView: UIView!
    private var timeContainerView: UIStackView!
    private var calendarIconImageView: UIImageView!
    private var clockIconImageView: UIImageView!
    private var dateLabel: UILabel!
    private var timeLabel: UILabel!
    private var vetInfoContainerView: UIView!
    private var vetInfoLabel: UILabel!
    private var animalsContainerView: UIView!
    private var animalsLabel: UILabel!
    
    private var middleSectionView: UIView! // Added
    private var bottomSectionView: UIView! // Added
    
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
        
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.orange.cgColor
        containerView.layer.borderWidth = 1
        
        let topSectionView = createSectionView(with: .lightGray)
        middleSectionView = createSectionView(with: .white) // Updated
        bottomSectionView = createSectionView(with: .white) // Updated
        
        containerView.addSubview(topSectionView)
        containerView.addSubview(middleSectionView) // Updated
        containerView.addSubview(bottomSectionView) // Updated
        
        let separatorView1 = createSeparatorView()
        let separatorView2 = createSeparatorView()
        
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
        clockIconImageView.contentMode = .scaleAspectFill
        dateLabel = UILabel()
        timeLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        clockIconImageView.tintColor = .orange
        calendarIconImageView.tintColor = .orange
        
        // Create two nested horizontal stack views for each block
        let calendarStackView = UIStackView(arrangedSubviews: [calendarIconImageView, dateLabel])
        calendarStackView.axis = .horizontal
        calendarStackView.distribution = .fill
        calendarStackView.spacing = 4
        
        let clockStackView = UIStackView(arrangedSubviews: [clockIconImageView, timeLabel])
        clockStackView.axis = .horizontal
        clockStackView.distribution = .fill
        clockStackView.spacing = 4
        
        // Create a spacer view for the space between clockStackView and the right edge
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal) // Allows the spacer to be compressed
        
        // Create a horizontal stack view containing the calendar and clock views with the spacer
        timeContainerView = UIStackView(arrangedSubviews: [calendarStackView, clockStackView, spacerView])
        timeContainerView.translatesAutoresizingMaskIntoConstraints = false
        timeContainerView.axis = .horizontal
        timeContainerView.distribution = .fill
        timeContainerView.spacing = 10
        containerView.addSubview(timeContainerView)
        
        // Add constraints for timeContainerView
        NSLayoutConstraint.activate([
            timeContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            timeContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            timeContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20) // Adjusted trailing constraint
        ])
    }




    
    private func setupVetInfoContainerView() {
        vetInfoContainerView = UIView()
        vetInfoContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(vetInfoContainerView)
        
        // Add contraints for vetInfoContainerView
        NSLayoutConstraint.activate([
            vetInfoContainerView.topAnchor.constraint(equalTo: middleSectionView.topAnchor, constant: 10), // Updated
            vetInfoContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            vetInfoContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        vetInfoLabel = UILabel()
        vetInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        vetInfoLabel.textAlignment = .left
        vetInfoLabel.textColor = .black
        vetInfoLabel.font = UIFont.systemFont(ofSize: 14)
        vetInfoLabel.numberOfLines = 0
        vetInfoContainerView.addSubview(vetInfoLabel)
        
        // Add constraints for vetInfoLabel
        NSLayoutConstraint.activate([
            vetInfoLabel.topAnchor.constraint(equalTo: vetInfoContainerView.topAnchor, constant: 10),
            vetInfoLabel.leadingAnchor.constraint(equalTo: vetInfoContainerView.leadingAnchor, constant: 10),
            vetInfoLabel.trailingAnchor.constraint(equalTo: vetInfoContainerView.trailingAnchor, constant: -10),
            vetInfoLabel.bottomAnchor.constraint(equalTo: vetInfoContainerView.bottomAnchor, constant: 10),
        ])
    }
    
    private func setupAnimalsContainerView() {
        animalsContainerView = UIView()
        animalsContainerView.translatesAutoresizingMaskIntoConstraints = false
//        animalsContainerView.backgroundColor = .yellow
        containerView.addSubview(animalsContainerView)
        
        // Add contraints for animalsContainerView
        NSLayoutConstraint.activate([
            animalsContainerView.topAnchor.constraint(equalTo: bottomSectionView.topAnchor, constant: 10), // Updated
            animalsContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            animalsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            animalsContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        animalsLabel = UILabel()
        animalsLabel.translatesAutoresizingMaskIntoConstraints = false
        animalsLabel.textAlignment = .left
        animalsLabel.textColor = .black
        animalsLabel.font = UIFont.systemFont(ofSize: 14)
        animalsLabel.numberOfLines = 0
        animalsContainerView.addSubview(animalsLabel)
        
        // Add constraints for animalsLabel
        NSLayoutConstraint.activate([
            animalsLabel.topAnchor.constraint(equalTo: animalsContainerView.topAnchor),
            animalsLabel.leadingAnchor.constraint(equalTo: animalsContainerView.leadingAnchor),
            animalsLabel.trailingAnchor.constraint(equalTo: animalsContainerView.trailingAnchor),
            animalsLabel.bottomAnchor.constraint(equalTo: animalsContainerView.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    func setup(_ appointment: Appointement) {
        configureDateTime(appointment.date)
        configureVetInfo(appointment.veterinarian)
        configureAnimals(appointment.animals)
    }
    
    private func configureDateTime(_ date: Date?) {
        guard let date = date else {
            dateLabel.text = "Unknown"
            timeLabel.text = "Unknown"
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .full
        let formattedDate = dateFormatter.string(from: date)
        dateLabel.text = formattedDate
        
        dateFormatter.dateFormat = "HH:mm"
        let formattedTime = dateFormatter.string(from: date)
        timeLabel.text = formattedTime
    }
    
    private func configureVetInfo(_ veterinarian: Veterinarian?) {
        guard let vet = veterinarian else {
            vetInfoLabel.text = "No veterinarian information available"
            return
        }
        
        var vetInfoText = "\(vet.name)"
        vetInfoText = vetInfoText.trimmingCharacters(in: .whitespacesAndNewlines)
        vetInfoLabel.text = vetInfoText
    }
    
    private func configureAnimals(_ animals: [Animal]?) {
        guard let animals = animals else {
            animalsLabel.text = "No animals assigned"
            return
        }
        
        let animalNames = animals.compactMap { $0.name }
        let animalsString = animalNames.joined(separator: ", ")
        animalsLabel.text = "Animals: \(animalsString)"
    }
}
