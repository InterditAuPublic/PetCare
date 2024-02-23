//
//  OtherCollectionViewCell.swift
//  PetCare
//
//  Created by Melvin Poutrel on 22/02/2024.
//

import UIKit

class OtherCollectionViewCell: UICollectionViewCell {
    var cellImageView: UIImageView!
    var cellTitleLbl: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("// ------- IN OTHERCELL ------- //")
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        print("// ------- SETUP SB OTHER ------- //")
        cellImageView = UIImageView()
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellImageView)
        
        cellTitleLbl = UILabel()
        cellTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellTitleLbl)
        
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellImageView.heightAnchor.constraint(equalToConstant: 20), // Adjust height as needed
            
            cellTitleLbl.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 8),
            cellTitleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellTitleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellTitleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setup(_ item: Appointement) {
        print("// ------- SETUP OTHER ------- //")
        cellImageView.image = UIImage(named: "veterinary")
        cellTitleLbl.text = item.descriptionRdv
    }
}
