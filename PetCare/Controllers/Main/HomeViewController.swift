//
//  HomeViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class HomeViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var appointments: [Appointement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan

        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAppointments()
    }
    
    

    private func setupCollectionView() {
        // Create a collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        // Create a collection view
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppointmentCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentCell")

        view.addSubview(collectionView)

        // Add constraints to the collection view if needed
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             collectionView.topAnchor.constraint(equalTo: view.topAnchor),
             collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
    }

    private func fetchAppointments() {
        if let fetchedAppointments = CoreDataManager.shared.fetchAppointements() {
            appointments = fetchedAppointments
            print("appointement")
            collectionView.reloadData()
        }
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appointments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCell", for: indexPath) as? AppointmentCollectionViewCell else {
            return UICollectionViewCell()
        }

        let appointment = appointments[indexPath.item]
        cell.configure(with: appointment)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust the size based on your requirements
        return CGSize(width: collectionView.bounds.width - 20, height: 100)
    }

    // Add more UICollectionViewDelegateFlowLayout methods as needed
}
