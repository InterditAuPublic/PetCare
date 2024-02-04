//
//  AnimalDetailView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 11/01/2024.
//

import UIKit

class AnimalDetailView: UIScrollView {
    
    var animal: Animal? {
        didSet {
            updateUI()
        }
    }
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private let infoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let animalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let animalAgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let animalBreedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let birthdateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private var animalCollectionView: UICollectionView!
    
    init(animal: Animal?) {
        super.init(frame: .zero)
        self.animal = animal
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        addSubview(contentView)
        contentView.addSubview(animalImageView)
        contentView.addSubview(infoContainer)
        infoContainer.addSubview(optionsStackView)
        infoContainer.addSubview(animalNameLabel)
        infoContainer.addSubview(animalAgeLabel)
        infoContainer.addSubview(animalBreedLabel)
        infoContainer.addSubview(birthdateLabel)
        
        
        let animalLayout = UICollectionViewFlowLayout()
        animalLayout.scrollDirection = .horizontal

        animalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: animalLayout)
        animalCollectionView.backgroundColor = .orange
        animalCollectionView.dataSource = self
        animalCollectionView.delegate = self
        animalCollectionView.register(AnimalDetailCollectionViewCell.self, forCellWithReuseIdentifier: "AnimalCell")
        animalCollectionView.allowsSelection = true
        animalCollectionView.allowsMultipleSelection = false
        animalCollectionView.translatesAutoresizingMaskIntoConstraints = false


        infoContainer.addSubview(animalCollectionView)
        
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            animalImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            animalImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            animalImageView.heightAnchor.constraint(equalToConstant: 200),
            
            infoContainer.topAnchor.constraint(equalTo: animalImageView.bottomAnchor),
            infoContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            optionsStackView.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 10),
            optionsStackView.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            optionsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            animalNameLabel.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 20),
            animalNameLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            animalNameLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            
            animalAgeLabel.topAnchor.constraint(equalTo: animalNameLabel.bottomAnchor, constant: 10),
            animalAgeLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            animalAgeLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            
            animalBreedLabel.topAnchor.constraint(equalTo: animalAgeLabel.bottomAnchor, constant: 10),
            animalBreedLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            animalBreedLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            
            birthdateLabel.topAnchor.constraint(equalTo: animalBreedLabel.bottomAnchor, constant: 10),
            birthdateLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            birthdateLabel.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
         
            animalCollectionView.topAnchor.constraint(equalTo: birthdateLabel.bottomAnchor, constant: 20),
            animalCollectionView.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 20),
            animalCollectionView.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -20),
            animalCollectionView.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -20),
        ])

        // Add the options to the stack view
        let options = ["Vaccinations", "Weight", "Food", "Health"]
        for option in options {
            let optionButton = UIButton()
            optionButton.setTitle(option, for: .normal)
            optionButton.setTitleColor(.black, for: .normal)
            optionButton.backgroundColor = .white
            optionButton.layer.cornerRadius = 10
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = UIColor.black.cgColor
            optionButton.translatesAutoresizingMaskIntoConstraints = false
            optionsStackView.addArrangedSubview(optionButton)
        }
        
        updateUI()
    }
    
    private func updateUI() {
        guard let animal = animal else { return }
        
        let defaultImage: UIImage
        if animal.species?.rawValue == "Dog" {
            defaultImage = UIImage(named: "dog_default_image") ?? UIImage()
        } else {
            defaultImage = UIImage(named: "cat_default_image") ?? UIImage()
        }
        
        let age = animal.birthdate?.timeIntervalSince1970
        
        animalImageView.image = defaultImage
        animalNameLabel.text = animal.name
        animalAgeLabel.text = "Age: \(age ?? 0) seconds"
        animalBreedLabel.text = "Breed: \(animal.breed ?? "")"
        birthdateLabel.text = "Birthdate: \(formattedBirthdate())"
    }
    
    private func formattedBirthdate() -> String {
        guard let birthdate = animal?.birthdate else {
            return "Unknown"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthdateString = dateFormatter.string(from: birthdate)
        
        let currentDate = Date()
        let currentDateStr = dateFormatter.string(from: currentDate)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: birthdate, to: currentDate)
        
        if let years = components.year, let months = components.month, let days = components.day {
            return "\(years) years, \(months) months"
        } else {
            return "Unknown"
        }
    }
    
}

extension AnimalDetailView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCell", for: indexPath) as! AnimalDetailCollectionViewCell
        
        cell.configure(title: "Title", value:"Value")
        
        return cell
    }
}
