//
//  PortraitCollectionReusableView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/02/2024.
//

import UIKit

class AppointementCollectionViewCell: UICollectionViewCell {
    private var cellImageView: UIImageView!
    private var cellTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        cellImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        cellTitleLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()
        
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellTitleLabel)
        
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellImageView.heightAnchor.constraint(equalTo: cellImageView.heightAnchor), // Adjust height as needed
            
            cellTitleLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 8),
            cellTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setup(_ item: Appointement) {
        cellImageView.image = UIImage(named: "veterinary")
        if let date = item.date {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "fr_FR") // French locale
                    dateFormatter.dateFormat = "dd MMMM yyyy" // Custom date format
                    let formattedDate = dateFormatter.string(from: date)
                    cellTitleLabel.text = formattedDate
                } else {
                    cellTitleLabel.text = "Unknown"
                }
    }
}
