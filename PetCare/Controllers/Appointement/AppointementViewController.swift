//
//  AppointementViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit
import CoreData

class AppointementViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var noAppointementView: UIView!
    var appointements: [Appointement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add button to navigation bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        addButton.tintColor = .orange
        navigationItem.rightBarButtonItem = addButton
        
        // Initialize collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        // Create collection view
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppointementCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentCollectionViewCell")
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        // Constraints for collection view
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Create no appointment view
        noAppointementView = UIView()
        noAppointementView.translatesAutoresizingMaskIntoConstraints = false
        noAppointementView.backgroundColor = .white
        let label = UILabel()
        label.text = "No appointments available."
        label.translatesAutoresizingMaskIntoConstraints = false
        noAppointementView.addSubview(label)
        view.addSubview(noAppointementView)
        
        // Constraints for no appointment view
        NSLayoutConstraint.activate([
            noAppointementView.topAnchor.constraint(equalTo: view.topAnchor),
            noAppointementView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noAppointementView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noAppointementView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Fetch appointments from Core Data
        fetchAppointments()
        
        // Update UI
        updateUI()
    }
    
    func fetchAppointments() {
        guard let fetchedAppointments = CoreDataManager.shared.fetchAppointementsSortedByDate() else {
            print("Failed to fetch appointments")
            return
        }
        appointements = fetchedAppointments
        print(appointements)
    }
    
    func updateUI() {
        collectionView.reloadData()
        if appointements.isEmpty {
            collectionView.isHidden = true
            noAppointementView.isHidden = false
        } else {
            collectionView.isHidden = false
            noAppointementView.isHidden = true
        }
    }

    @objc func didTapAddButton() {
        // Navigate to the view controller where user can add appointments
        let addAppointmentVC = AppointementViewController()
        navigationController?.pushViewController(addAppointmentVC, animated: true)
    }
}

extension AppointementViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appointements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCollectionViewCell", for: indexPath) as? AppointementCollectionViewCell else {
            fatalError("Unable to dequeue AppointementCollectionViewCell")
        }
        
        let appointement = appointements[indexPath.item]
        // Configure the cell with appointement details
        
        cell.setup(appointement)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust the size of the cell according to your requirement
        return CGSize(width: collectionView.bounds.width - 20, height: 100)
    }
}
