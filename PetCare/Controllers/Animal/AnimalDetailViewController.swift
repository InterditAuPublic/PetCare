import UIKit

class AnimalDetailViewController: UIViewController {

    // MARK: - Properties

    var animalDetailView: AnimalDetailView?
    var selectedAnimal: Animal?

    // MARK: - Initialization

    init(selectedAnimal: Animal) {
        self.selectedAnimal = selectedAnimal
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white

        animalDetailView = AnimalDetailView(animal: selectedAnimal)
        guard let animalDetailView = animalDetailView else { return }

        view.addSubview(animalDetailView)
        animalDetailView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animalDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animalDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animalDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animalDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }

    // MARK: - Actions

    @objc private func editButtonTapped() {
        // navigate to the edit view controller
        guard let selectedAnimal = selectedAnimal else { return }
        let editAnimalViewController = EditAnimalViewController(animal: selectedAnimal)
        navigationController?.pushViewController(editAnimalViewController, animated: true)
    }

}

extension AnimalDetailViewController: FormDelegate {
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
        // change the value of the animal
        print("In update")
        // update the animal in the database
    }
}
