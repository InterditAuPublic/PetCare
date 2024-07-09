import UIKit

class AnimalDetailsViewController: UIViewController {

    let animalDetailsView = AnimalDetailsView()
    var animal: Animal?

    init(animal: Animal) {
        self.animal = animal
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func loadView() {
        view = animalDetailsView
        
        // Configure the view with animal data after view is loaded
        if let animal = animal {
            animalDetailsView.configure(with: animal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = animal?.name
        setupUI()
    }


    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }

    // MARK: - Actions

    @objc private func editButtonTapped() {
        guard let animal = animal else { return }
        let editAnimalViewController = EditAnimalViewController(animal: animal)
        navigationController?.pushViewController(editAnimalViewController, animated: true)
    }
}
