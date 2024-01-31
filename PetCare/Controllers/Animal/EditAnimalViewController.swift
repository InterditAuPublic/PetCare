//
//  EditAnimalViewController.swift
//  PetCare
//
//  Created by Melvin Poutrel on 31/01/2024.
//

import UIKit

class EditAnimalViewController: UIViewController {

    var editAnimalView: AnimalDetailView?
    var animal: Animal?
    
    init(animal: Animal) {
        self.animal = animal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = animal?.name
        navigationItem.largeTitleDisplayMode = .never
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        editAnimalView = AnimalDetailView(animal: animal)
        guard let editAnimalView = editAnimalView else { return }
        
        view.addSubview(editAnimalView)
        editAnimalView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editAnimalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editAnimalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editAnimalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editAnimalView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        editAnimalView.animalForm?.delegate = self
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    @objc private func saveButtonTapped() {
        
        guard let animalForm = editAnimalView?.animalForm else { return }
        
        let formFields = animalForm.getFormFields()
        
        // go back to the previous view controller
        navigationController?.popViewController(animated: true)
    }
}

extension EditAnimalViewController: FormDelegate {
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
    }
}
