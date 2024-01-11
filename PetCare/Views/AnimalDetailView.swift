// AnimalDetailView.swift

import UIKit

class AnimalDetailView: UIScrollView {
    
    // MARK: - Properties
    var animalForm: AnimalForm?
    var selectedAnimal: Animal
    
    // MARK: - Initializers
    init(selectedAnimal: Animal) {
        self.selectedAnimal = selectedAnimal
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Configuration
    private func setupUI() {
        // Create an instance of AnimalForm
        animalForm = AnimalForm(frame: frame, animal: selectedAnimal)
        guard let animalForm = animalForm else { return }
        
        // Add AnimalForm as a subview
        addSubview(animalForm)
        // Venter the form in the scroll view
        animalForm.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        // Set up constraints for AnimalForm
        NSLayoutConstraint.activate([
            animalForm.topAnchor.constraint(equalTo: topAnchor),
            animalForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            animalForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            animalForm.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        animalForm.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    // MARK: - Actions
    
    @objc private func saveButtonTapped() {
        // Access form values from AnimalForm
        let formValues = animalForm?.getFormValues() ?? [:]
        print("Form values: \(formValues)")
    }
}
