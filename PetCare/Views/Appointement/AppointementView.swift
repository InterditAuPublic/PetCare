//
//  AppointementView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import UIKit
class AppointementView: UIView {
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        return datePicker
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description du RDV"
        return textField
    }()
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(datePicker)
        addSubview(descriptionTextField)
        addSubview(pickerView)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 200),
            
            descriptionTextField.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 50),
            
            pickerView.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pickerView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
