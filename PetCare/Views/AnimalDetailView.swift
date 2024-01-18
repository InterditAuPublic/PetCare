import UIKit

class AnimalDetailView: UIScrollView {

    var animalForm: AnimalForm?

    init(animal: Animal?) {
        super.init(frame: .zero)
        animalForm = AnimalForm(animal: animal)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        guard let animalForm = animalForm else { return }
        addSubview(animalForm)
        
        // Venter the form in the scroll view
        animalForm.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        // Set up constraints for AnimalForm
        NSLayoutConstraint.activate([
            animalForm.topAnchor.constraint(equalTo: topAnchor),
            animalForm.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            animalForm.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -20),
            animalForm.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
        ])
        
        animalForm.translatesAutoresizingMaskIntoConstraints = false
    }

}
