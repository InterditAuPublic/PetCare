import UIKit

class AnimalDetailsCell: UICollectionViewCell {

    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        valueLabel.font = UIFont.preferredFont(forTextStyle: .body)
        imageView.contentMode = .scaleAspectFit

        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel, imageView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    func configure(title: String, value: String?) {
        titleLabel.text = title
        valueLabel.text = value
        imageView.image = nil
    }

    func configure(title: String, image: UIImage) {
        titleLabel.text = title
        valueLabel.text = nil
        imageView.image = image
    }
}
