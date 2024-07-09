//
//  VeterinarianDetailViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class VeterinarianDetailViewController: UIViewController {
    
    var veterinarian: Veterinarian
    var veterinarianDetailView: VeterinarianDetailView?
    
    init(veterinarian: Veterinarian) {
        self.veterinarian = veterinarian
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "Dr ." + veterinarian.name
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
    }
    
    private func setupUI() {
        veterinarianDetailView = VeterinarianDetailView()
        guard let veterinarianDetailView = veterinarianDetailView else { return }

        view.addSubview(veterinarianDetailView)
        veterinarianDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            veterinarianDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            veterinarianDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            veterinarianDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            veterinarianDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        veterinarianDetailView.veterinarian = veterinarian
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc private func editButtonTapped() {
        // navigate to the edit view controller
        let veterinarianEditViewController = EditVeterinarianViewController(veterinarian: veterinarian)
        navigationController?.pushViewController(veterinarianEditViewController, animated: true)
    }
}
