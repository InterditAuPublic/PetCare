import UIKit

class AnimalHomeCollectionViewCell: UICollectionViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 36 // Adjust the corner radius to make it smaller
        
        // Add an additional border
        imageView.layer.borderWidth = 4 // Add border width
        imageView.layer.borderColor = UIColor.white.cgColor // Border color
        
        return imageView
    }()
    
    let borderView: UIView = {
        // Add a second border
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.cornerRadius = 40 // Larger corner radius to accommodate the first border
        borderView.layer.borderWidth = 4 // Border width
        borderView.layer.borderColor = UIColor.orange.cgColor // Border color
        return borderView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the image view and border view to the cell's content view
        contentView.addSubview(borderView)
        borderView.addSubview(cellImageView)
        contentView.addSubview(titleLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 80), // Adjust height as needed to make it smaller
            
            cellImageView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 4),
            cellImageView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 4),
            cellImageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -4),
            cellImageView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -4),
            
            titleLabel.topAnchor.constraint(equalTo: borderView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure the cell with the provided item
    func setup(_ item: Animal) {
        cellImageView.image = UIImage(named: item.image ?? "dog_default_image")
        titleLabel.text = item.name
    }
}
