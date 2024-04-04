//
//  AppointementViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//
import UIKit

class AppointementViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var appointements: [Appointement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
//        addButton.tintColor = .orange
        navigationItem.rightBarButtonItem = addButton
        
        // Initial setup
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchAppointements()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupViews() {
        // Initialize UICollectionView with flow layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppointmentCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentCell")
        collectionView.backgroundColor = .white
        
        // Add as subview and setup constraints
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchAppointements() {
        if let fetchedAppointements = CoreDataManager.shared.fetchAppointementsSortedByDate() {
            appointements = fetchedAppointements
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            if self.appointements.isEmpty {
                // Display the NoAppointmentView
                let noAppointmentView = NoAppointmentView()
                
                
                // Remove any existing UICollectionView
                self.collectionView.removeFromSuperview()
                
                // Add the NoAppointmentView
                self.view.addSubview(noAppointmentView)
                noAppointmentView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    noAppointmentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    noAppointmentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
                ])
            } else {
                // Reload UICollectionView data if needed
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension AppointementViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appointements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCollectionViewCell
        let appointement = appointements[indexPath.item]
        cell.configure(with: appointement)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AppointementViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        return CGSize(width: width, height: 100)
    }
}

// MARK: Actions
extension AppointementViewController {
    @objc func didTapAddButton() {
        self.navigationController?.pushViewController(AddAppointmentViewController(), animated: true)
    }
}
