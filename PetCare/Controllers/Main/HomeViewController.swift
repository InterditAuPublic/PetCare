//
//  HomeViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var appointmentCollectionView: UICollectionView!
    private var animalCollectionView: UICollectionView!
    private var collectionView: UICollectionView!
    private var appointments: [Appointement] = []
    private var animals: [Animal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAppointments()
        fetchAnimals()
    }
    
    private func setupCollectionView() {
        // Create a collection view layout for animals
        let animalLayout = UICollectionViewFlowLayout()
        animalLayout.scrollDirection = .horizontal

        // Create the animal collection view
        animalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: animalLayout)
        animalCollectionView.backgroundColor = .white
        animalCollectionView.dataSource = self
        animalCollectionView.delegate = self
        animalCollectionView.register(AnimalCollectionViewCell.self, forCellWithReuseIdentifier: "AnimalCell")

        // Add the animal collection view to the view
        view.addSubview(animalCollectionView)

        // Add constraints to the animal collection view
        animalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animalCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            animalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animalCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])

        // Create a collection view layout for appointments
        let appointmentLayout = UICollectionViewFlowLayout()
        appointmentLayout.scrollDirection = .vertical

        // Create the appointment collection view
        appointmentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: appointmentLayout)
        appointmentCollectionView.backgroundColor = .red
        appointmentCollectionView.dataSource = self
        appointmentCollectionView.delegate = self
        appointmentCollectionView.register(AppointmentCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentCell")

        // Add the appointment collection view to the view
        view.addSubview(appointmentCollectionView)

        // Add constraints to the appointment collection view
        appointmentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appointmentCollectionView.topAnchor.constraint(equalTo: animalCollectionView.bottomAnchor),
            appointmentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appointmentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            appointmentCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    
    private func fetchAppointments() {
        if let fetchedAppointments = CoreDataManager.shared.fetchAppointements() {
            appointments = fetchedAppointments
            appointmentCollectionView.reloadData()
        }
    }
    
    private func fetchAnimals() {
        if let fetchedAnimals = CoreDataManager.shared.fetchAnimals() {
            animals = fetchedAnimals
            animalCollectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == appointmentCollectionView {
            return appointments.count
        } else if collectionView == animalCollectionView {
            return animals.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == appointmentCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCell", for: indexPath) as? AppointmentCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let appointment = appointments[indexPath.item]
            cell.configure(with: appointment)
            
            return cell
        } else if collectionView == animalCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCell", for: indexPath) as? AnimalCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let animal = animals[indexPath.item]
            cell.configure(with: animal)
            cell.backgroundColor = .blue
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust the size based on your requirements
        return CGSize(width: collectionView.bounds.width - 20, height: 120)
    }
    
    // Add more UICollectionViewDelegateFlowLayout methods as needed
}
