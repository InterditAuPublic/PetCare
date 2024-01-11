//
//  FormView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 11/01/2024.
//

import UIKit

protocol FormField {
    var labelText: String { get set }
    var placeholder: String { get set }
    func getValue() -> Any
    func getView() -> UIView
}

struct TextFormField: FormField {
    var labelText: String
    var placeholder: String
    var value: String?
    
    func getValue() -> Any {
        return value ?? ""
    }
    
    func getView() -> UIView {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.tintColor = .orange
        textField.text = value
        return textField
    }
}

struct DateFormField: FormField {
    var labelText: String
    var placeholder: String
    var value: Date?
    
    func getValue() -> Any {
        return value ?? Date()
    }
    
    func getView() -> UIView {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.date = value ?? Date()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.tintColor = .orange
        return datePicker
    }
}

class FormView: UIStackView {
    
    var formFields = [FormField]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        axis = .vertical
        spacing = 10
        
        for formField in formFields {
            addFormFieldView(for: formField)
        }
    }
    
    private func addFormFieldView(for formField: FormField) {
        let formFieldView = UIStackView()
        formFieldView.axis = .vertical
        formFieldView.spacing = 10
//        formFieldView.alignment = .center
        
        let label = UILabel()
        label.text = formField.labelText
        label.translatesAutoresizingMaskIntoConstraints = false

        
        let inputView = formField.getView()
        
        formFieldView.addArrangedSubview(label)
        formFieldView.addArrangedSubview(inputView)
        
        addArrangedSubview(formFieldView)
    }
    
    func addFormField(_ formField: FormField) {
        formFields.append(formField)
        addFormFieldView(for: formField)
    }
    
    func addCustomView(_ customView: UIView) {
        addArrangedSubview(customView)
    }
    
    func getFormFields() -> [FormField] {
            return formFields
        }
    
    func getFormValues() -> [String: Any] {
        var formValues = [String: Any]()
        
        for formField in formFields {
            formValues[formField.labelText] = formField.getValue()
        }
        
        return formValues
    }
}
