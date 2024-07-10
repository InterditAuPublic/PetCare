//
//  VeterinarianDetailViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class VeterinarianDetailViewController: UIViewController {
    
    // MARK: - Properties

    var veterinarian: Veterinarian
    var veterinarianDetailView: VeterinarianDetailView?

    // MARK: - Initialization

    // Custom initializer to pass the veterinarian object
    init(veterinarian: Veterinarian) {
        self.veterinarian = veterinarian
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color for the view
        view.backgroundColor = .white
        
        // Set the navigation title to the veterinarian's name
        navigationItem.title = "Dr. " + veterinarian.name
        navigationItem.largeTitleDisplayMode = .never
        
        // Set up the UI elements
        setupUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        // Initialize and add the custom veterinarian detail view
        veterinarianDetailView = VeterinarianDetailView()
        guard let veterinarianDetailView = veterinarianDetailView else { return }

        view.addSubview(veterinarianDetailView)
        veterinarianDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the detail view
        NSLayoutConstraint.activate([
            veterinarianDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            veterinarianDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            veterinarianDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            veterinarianDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Populate the detail view with the veterinarian's data
        veterinarianDetailView.veterinarian = veterinarian
        
        // Add an edit button to the navigation bar
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }

    // MARK: - Actions

    // Method to handle the edit button tap
    @objc private func editButtonTapped() {
        // Navigate to the edit view controller
        let veterinarianEditViewController = EditVeterinarianViewController(veterinarian: veterinarian)
        navigationController?.pushViewController(veterinarianEditViewController, animated: true)
    }
}
