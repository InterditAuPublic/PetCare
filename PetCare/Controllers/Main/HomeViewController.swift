//
//  HomeViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class HomeViewController: UIViewController, AnimalCellDelegate {

    private var appointmentCollectionView: UICollectionView!
    private var animalCollectionView: UICollectionView!
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
        setupAnimalCollectionView()
        setupAppointmentCollectionView()
    }

    private func setupAnimalCollectionView() {
        let animalLayout = UICollectionViewFlowLayout()
        animalLayout.scrollDirection = .horizontal

        animalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: animalLayout)
        animalCollectionView.backgroundColor = .white
        animalCollectionView.dataSource = self
        animalCollectionView.delegate = self
        animalCollectionView.register(AnimalCollectionViewCell.self, forCellWithReuseIdentifier: "AnimalCell")
        animalCollectionView.allowsSelection = true
        animalCollectionView.allowsMultipleSelection = false

        view.addSubview(animalCollectionView)

        animalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animalCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            animalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animalCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupAppointmentCollectionView() {
        let appointmentLayout = UICollectionViewFlowLayout()
        appointmentLayout.scrollDirection = .vertical

        appointmentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: appointmentLayout)
        appointmentCollectionView.backgroundColor = .red
        appointmentCollectionView.dataSource = self
        appointmentCollectionView.delegate = self
        appointmentCollectionView.register(AppointmentCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentCell")

        view.addSubview(appointmentCollectionView)

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
        return collectionView == appointmentCollectionView ? appointments.count : animals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == appointmentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCollectionViewCell
            let appointment = appointments[indexPath.item]
            cell.configure(with: appointment)
            return cell
        } else if collectionView == animalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCell", for: indexPath) as! AnimalCollectionViewCell
            let animal = animals[indexPath.item]
            cell.delegate = self
            cell.configure(with: animal)
//            cell.backgroundColor = .orange
            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: 120)
    }

    func didTap(on cell: AnimalCollectionViewCell) {
        if let indexPath = animalCollectionView.indexPath(for: cell) {
            let selectedAnimal = animals[indexPath.item]
            let animalDetailVC = AnimalDetailViewController(selectedAnimal: selectedAnimal)
            navigationController?.pushViewController(animalDetailVC, animated: true)
        } else {
            print("No index!")
        }
    }
}
