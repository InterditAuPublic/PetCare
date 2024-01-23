//
//  VeterinarianDetailViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit

class VeterinarianDetailViewController: UIViewController {

var veterinarian: Veterinarian?
var veterinarianDetailView: VeterinarianDetailView?

init(veterinarian: Veterinarian) {
    self.veterinarian = veterinarian
    super.init(nibName: nil, bundle: nil)
}

  required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = veterinarian?.name
        navigationItem.largeTitleDisplayMode = .never
        setupUI()

    }


    private func setupUI() {
        guard let veterinarian = veterinarian else { return }
        let veterinarianDetailView = VeterinarianDetailView(veterinarian: veterinarian)
        view.addSubview(veterinarianDetailView)
        veterinarianDetailView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            veterinarianDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            veterinarianDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            veterinarianDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            veterinarianDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    /*veterinarianDetailView.veterinarianForm?.delegate = self*/

        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }

    @objc private func editButtonTapped() {
     
        // navigate to the edit view controller
        guard let veterinarian = veterinarian else { return }
        let veterinarianEditViewController = VeterinarianEditViewController(veterinarian: veterinarian)
        navigationController?.pushViewController(veterinarianEditViewController, animated: true)
    }
    
}
