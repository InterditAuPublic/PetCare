//
//  AddAppointementViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 17/03/2024.
//
import UIKit

class AppointmentFormCollectionViewCell: UICollectionViewCell {
    
    var appointmentForm: AppointmentForm!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialize appointment form
        appointmentForm = AppointmentForm(appointment: nil)
        appointmentForm.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(appointmentForm)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            appointmentForm.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            appointmentForm.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            appointmentForm.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            appointmentForm.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddAppointmentViewController: UIViewController, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        title = "Add Appointment"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAppointment))
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            return self.createSectionLayout()
        }
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(AppointmentFormCollectionViewCell.self, forCellWithReuseIdentifier: "AppointmentFormCell")
        view.addSubview(collectionView)
    }
    
    private func createSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // Only one item in the section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentFormCell", for: indexPath) as! AppointmentFormCollectionViewCell
        cell.backgroundColor = .lightGray
        return cell
    }
    
    @objc private func saveAppointment() {
        // Save appointment logic
        navigationController?.popViewController(animated: true)
    }
}
