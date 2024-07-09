import UIKit

class AnimalDetailsView: UIView {
    
    // UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [NSLocalizedString("info", comment: ""), NSLocalizedString("details", comment: "")])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let commentsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = false
        textView.isSelectable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    // Label Generators
    private func createLabel(font: UIFont, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textAlignment = textAlignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    // Labels for details
    private lazy var nameLabel = createLabel(font: .boldSystemFont(ofSize: 24), textAlignment: .center)
    private lazy var speciesLabel = createLabel(font: .systemFont(ofSize: 18))
    private lazy var sexeLabel = createLabel(font: .systemFont(ofSize: 18))
    private lazy var sterilizedLabel = createLabel(font: .systemFont(ofSize: 18))
    private lazy var breedLabel = createLabel(font: .systemFont(ofSize: 18))
    private lazy var birthdateLabel = createLabel(font: .systemFont(ofSize: 18))
    private lazy var weightLabel = createLabel(font: .systemFont(ofSize: 18))
    private lazy var colorLabel = createLabel(font: .systemFont(ofSize: 18))

    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // Setup View
    private func setupView() {
        backgroundColor = .white

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(animalImageView)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(detailsStackView)
        contentView.addSubview(commentsTextView)

        // Setup segmented control action
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)

        setupConstraints()
        setupDetailsStackView()
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            animalImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            animalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            animalImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            animalImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65),

            segmentedControl.topAnchor.constraint(equalTo: animalImageView.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            detailsStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            commentsTextView.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: 20),
            commentsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            commentsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            commentsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        // Initially hide commentsTextView
        commentsTextView.isHidden = true
    }

    private func setupDetailsStackView() {
        detailsStackView.addArrangedSubview(nameLabel)
        detailsStackView.addArrangedSubview(speciesLabel)
        detailsStackView.addArrangedSubview(sexeLabel)
        detailsStackView.addArrangedSubview(sterilizedLabel)
        detailsStackView.addArrangedSubview(breedLabel)
        detailsStackView.addArrangedSubview(birthdateLabel)
        detailsStackView.addArrangedSubview(weightLabel)
        detailsStackView.addArrangedSubview(colorLabel)
    }

    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        UIView.transition(with: contentView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            switch sender.selectedSegmentIndex {
            case 0:
                self.detailsStackView.isHidden = false
                self.commentsTextView.isHidden = true
            case 1:
                self.detailsStackView.isHidden = true
                self.commentsTextView.isHidden = false
            default:
                break
            }
        }, completion: nil)
    }

    // Configure View with Animal Data
    func configure(with animal: Animal) {
        if let imageData = animal.image {
            animalImageView.image = UIImage(data: imageData)
        } else {
            switch animal.species {
            case .dog:
                animalImageView.image = UIImage(named: "dog_default_image")
            case .cat:
                animalImageView.image = UIImage(named: "cat_default_image")
            case .none:
                animalImageView.image = UIImage(named: "default_image")
            }
        }

        nameLabel.text = animal.name
        speciesLabel.text = NSLocalizedString("Species: ", comment: "") + (animal.species?.text ?? "Unknown")
        sexeLabel.text = NSLocalizedString("Sex: ", comment: "") + (animal.sexe ? NSLocalizedString("Female", comment: "") : NSLocalizedString("Male", comment: ""))
        sterilizedLabel.text = NSLocalizedString("Sterilized: ", comment: "") + (animal.sterilized ? NSLocalizedString("yes", comment: "") : NSLocalizedString("no", comment: ""))
        breedLabel.text = NSLocalizedString("Breed: ", comment: "") + (animal.breed ?? "Unknown")

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        birthdateLabel.text = NSLocalizedString("Birthdate: ", comment: "") + (animal.birthdate != nil ? dateFormatter.string(from: animal.birthdate!) : "Unknown")

        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        weightLabel.text = NSLocalizedString("Weight: ", comment: "") + (animal.weight != nil ? "\(numberFormatter.string(from: NSNumber(value: animal.weight!))!) kg" : "Unknown")

        colorLabel.text = NSLocalizedString("Color: ", comment: "") + (animal.color ?? "Unknown")
        commentsTextView.text = animal.comments ?? NSLocalizedString("No comments", comment: "")
    }
}
