//
//  NoAnimalView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import UIKit

class NoAnimalView: UIView {
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add a new animal", for: .normal)
        button.setTitle(NSLocalizedString("add_animal", comment: ""), for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.tintColor = .orange
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddButton))
        button.addGestureRecognizer(tapGesture)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    @objc private func didTapImageView() {
        delegate?.didTapAddButton()
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "You don't have any animals yet. \nTap the button below to add a new animal."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    weak var delegate: NoAnimalsDelegate?
    
    @objc func didTapAddButton() {
        delegate?.didTapAddButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addButton)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.frame = CGRect(x: 20, y: 100, width: frame.size.width-40, height: 52)
        label.frame = CGRect(x: 20, y: 20, width: frame.size.width-40, height: 100)
        imageView.frame = CGRect(x: (frame.size.width-100)/2, y: 200, width: 200, height: 200)
    }
}

protocol NoAnimalsDelegate: AnyObject {
    func didTapAddButton()
}
