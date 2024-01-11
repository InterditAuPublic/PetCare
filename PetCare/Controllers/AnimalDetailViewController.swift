// AnimalDetailViewController.swift

import UIKit

class AnimalDetailViewController: UIViewController {
    
    var animalDetailView: AnimalDetailView?
    var selectedAnimal: Animal?
    
    init(selectedAnimal: Animal) {
        // Initialize 'selectedAnimal' before calling super.init()
        self.selectedAnimal = selectedAnimal
        super.init(nibName: nil, bundle: nil)
        // Initialize any additional configurations or dependencies here
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Example: Set up AnimalDetailView
        animalDetailView = AnimalDetailView(selectedAnimal: selectedAnimal ?? Animal())
        guard let animalDetailView = animalDetailView else { return }
        
        // Add AnimalDetailView as a subview
        view.addSubview(animalDetailView)
        animalDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints for AnimalDetailView
        NSLayoutConstraint.activate([
            animalDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animalDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animalDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animalDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
//        animalDetailView.animalForm?.loadAnimalDetails(animal: selectedAnimal)
        animalDetailView.animalForm?.animal = selectedAnimal
        
        // Add Save button to rightBarButtonItem
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func saveButtonTapped() {
        // Example: Retrieve form values from AnimalForm
        print("in save Detail")

        let formValues = animalDetailView?.animalForm?.getFormValues() ?? [:]
        print("Form values: \(formValues)")

        // Example: Save form values to Core Data
        CoreDataManager.shared.saveAnimal(animal: selectedAnimal ?? Animal())
        

    }
}
