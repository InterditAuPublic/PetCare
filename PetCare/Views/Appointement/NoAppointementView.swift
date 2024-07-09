//
//  NoAppointementView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 13/03/2024.
//

import UIKit

class NoAppointmentView: UIView {
    
    weak var delegate: NoAppointmentDelegate?
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.setTitle(NSLocalizedString("add_appointment", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("no_appointments_message", comment: "You don't have any appointment yet. \nTap the button below to add a new one.")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(addButton)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    @objc private func didTapAddButton() {
        delegate?.didTapAddAppointment()
    }
}

protocol NoAppointmentDelegate: AnyObject {
    func didTapAddAppointment()
}
