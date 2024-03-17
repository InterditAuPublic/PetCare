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
        let button = UIButton(type: .system)
        button.setTitle("Add Appointment", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "No appointments available."
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
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
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40)
        ])
        
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    @objc private func didTapAddButton() {
        print("Button tapped")
        delegate?.didTapAddAppointment()
    }
}

protocol NoAppointmentDelegate: AnyObject {
    func didTapAddAppointment()
}
