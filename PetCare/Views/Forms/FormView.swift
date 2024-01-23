//
//  FormView.swift
//  PetCare
//
//  Created by Melvin Poutrel on 15/01/2024.
//

import UIKit

// Define a protocol for form fields
protocol FormField {
    var labelText: String? { get set }
    var placeholder: String? { get set }
    var value: Any? { get set }
    var values: Any? { get set }
    var selected: Any? { get set}
    var inputViewType: InputViewType { get }
}

// Define an enum for input view types
enum InputViewType {
    case text, date, segment, image, picker
}

// Define a protocol for the form itself
protocol FormDelegate: AnyObject {
    func formDidUpdateValue(_ value: Any?, forField field: FormField)
}

// Implement a basic text form field conforming to FormField
struct TextFormField: FormField {
    var selected: Any?
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var values: Any?
    var inputViewType: InputViewType = .text
}

// Implement a date form field conforming to FormField
struct DateFormField: FormField {
    var selected: Any?
    
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var values: Any?
    var inputViewType: InputViewType = .date
}

// Implement a segmented control form field conforming to FormField
struct SegmentFormField: FormField {
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var selected: Any?
    var values: Any?
    var inputViewType: InputViewType = .segment
}

// Implement an image form field conforming to FormField
struct ImageFormField: FormField {
    var selected: Any?
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var values: Any?
    var picker: Bool?
    var inputViewType: InputViewType = .image
}


struct PickerFormField: FormField {
    var selected: Any?
    var values: Any?
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var inputViewType: InputViewType = .picker
}

// Implement the main Form class
class FormView: UIStackView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: FormDelegate?
    
    public var formFields = [FormField]()
    
    // Initialize the form with an array of form fields
    init(formFields: [FormField]) {
        super.init(frame: .zero)
        self.formFields = formFields
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func addFormField(_ formField: FormField) {
        formFields.append(formField)
        addFormFieldView(for: formField)
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
        formFieldView.distribution = .fillProportionally
        
        formFieldView.spacing = 5
        
        let bottomSpacing = UIView()
        bottomSpacing.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        formFieldView.addArrangedSubview(bottomSpacing)
        
        let label = UILabel()
        label.text = formField.labelText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let inputView = createInputView(for: formField)
        
        formFieldView.addArrangedSubview(label)
        formFieldView.addArrangedSubview(inputView)
        
        addArrangedSubview(formFieldView)
    }
    
    private func createInputView(for formField: FormField) -> UIView {
        switch formField.inputViewType {
        case .text:
            return createTextField(for: formField)
        case .date:
            return createDatePicker(for: formField)
        case .segment:
            return createSegmentedControl(for: formField)
        case .image:
            return createImageView(for: formField)
        case .picker:
            return createPickerView(for: formField)
        }
    }
    
    private func createTextField(for formField: FormField) -> UITextField {
        let textField = UITextField()
        textField.placeholder = formField.placeholder
        textField.borderStyle = .roundedRect
        textField.tintColor = .orange
        textField.text = formField.value as? String
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }
    
    private func createDatePicker(for formField: FormField) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.date = formField.value as? Date ?? Date()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.tintColor = .orange
        datePicker.addTarget(self, action: #selector(datePickerDidChange(_:)), for: .valueChanged)
        return datePicker
    }
    
    private func createSegmentedControl(for formField: FormField) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: formField.values as? [String] ?? [])
        segmentedControl.tintColor = .orange
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange(_:)), for: .valueChanged)
        return segmentedControl
    }
    
    private func createImageView(for formField: FormField) -> UIView {
        guard let imageFormField = formField as? ImageFormField else {
            fatalError("Invalid form field type for image")
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: (imageFormField.value as? String)!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.tintColor = .orange
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = imageFormField.picker ?? false
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        if imageFormField.picker == true {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
        }
        
        return imageView
    }
    
    
    private func createPickerView(for formField: FormField) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.tintColor = .orange
        pickerView.dataSource = self
        pickerView.delegate = self
        setupPickerViewDefault(for: formField)
        
        return pickerView
    }
    
    private func setupPickerViewDefault(for formField: FormField) {
        guard let index = formFields.firstIndex(where: { $0 is PickerFormField }),
              var pickerFormField = formFields[index] as? PickerFormField,
              let values = pickerFormField.values as? [Species] else {
            return
        }
        
        pickerFormField.value = values.first?.rawValue
        formFields[index] = pickerFormField
    }
    
    private func setupPickerViewSelectedRow(for formField: FormField) {
        print("setupPickerViewSelectedRow")
        guard let index = formFields.firstIndex(where: { $0 is PickerFormField }),
              var pickerFormField = formFields[index] as? PickerFormField,
              
                let values = pickerFormField.values as? [Species] else {
            print("return")
            return
        }
        
        print("values : \(values)")
        if let value = pickerFormField.value as? String,
           let selectedRow = values.firstIndex(where: { $0.rawValue == value }) {
            print("selectedRow : \(selectedRow)")
            print("pickerFormField : \(pickerFormField)")
            print("pickerFormField.value : \(pickerFormField.value)")
            
            pickerFormField.value = selectedRow
            formFields[index] = pickerFormField
        }
        
        
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        guard let index = formFields.firstIndex(where: { ($0 as? TextFormField)?.placeholder == sender.placeholder }) else {
            return
        }
        formFields[index].value = sender.text
        delegate?.formDidUpdateValue(sender.text, forField: formFields[index])
    }
    
    @objc private func datePickerDidChange(_ sender: UIDatePicker) {
        guard let index = formFields.firstIndex(where: { $0 is DateFormField }) else {
            return
        }
        
        if let dateFormField = formFields[index] as? DateFormField {
            formFields[index].value = sender.date
            delegate?.formDidUpdateValue(sender.date, forField: dateFormField)
        }
    }
    
    @objc private func segmentedControlDidChange(_ sender: UISegmentedControl) {
        guard let index = formFields.firstIndex(where: { ($0 as? SegmentFormField)?.placeholder == nil }) else {
            return
        }
        formFields[index].value = sender.titleForSegment(at: sender.selectedSegmentIndex)
        delegate?.formDidUpdateValue(sender.titleForSegment(at: sender.selectedSegmentIndex), forField: formFields[index])
    }
    
    @objc private func imageViewTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        // Present the image picker
        if let viewController = findViewController() {
            viewController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // UIImagePickerControllerDelegate method to handle image selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the selected image from the info dictionary
        if let pickedImage = info[.editedImage] as? UIImage, let index = formFields.firstIndex(where: { $0 is ImageFormField }) {
            guard let imageFormField = formFields[index] as? ImageFormField else {
                fatalError("Invalid form field type for image")
            }
            
            if imageFormField.picker == true {
                // Create a mutable copy of the ImageFormField
                var updatedImageFormField = imageFormField
                // Update the value of the ImageFormField with the selected image
                updatedImageFormField.value = pickedImage
                // Replace the old ImageFormField with the updated one in the formFields array
                formFields[index] = updatedImageFormField
                // Notify the delegate about the update
                delegate?.formDidUpdateValue(pickedImage, forField: updatedImageFormField)
            }
            
            // Update the corresponding UIImageView in the UI
            for subview in arrangedSubviews {
                if let imageView = subview.subviews.compactMap({ $0 as? UIImageView }).first {
                    imageView.image = pickedImage
                }
            }
        }
        
        // Dismiss the image picker
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension FormView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // func to set the number of rows in the picker view based on the number of values in the picker form field
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let index = formFields.firstIndex(where: { $0 is PickerFormField }) else {
            return 0
        }
        
        if let pickerFormField = formFields[index] as? PickerFormField,
           let values = pickerFormField.values as? [Species] {
            return values.count
        }
        return 0
    }
    
    // func to set the title for each row in the picker view based on the values in the picker form field
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let index = formFields.firstIndex(where: { $0 is PickerFormField }) else {
            return nil
        }
        
        if let pickerFormField = formFields[index] as? PickerFormField,
           let values = pickerFormField.values as? [Species] {
            return "\(values[row].rawValue)"
        }
        return nil
    }
    
    // func to set the default value for the picker view
    func setPickerViewDefaultValue(for formField: FormField) {
        guard let index = formFields.firstIndex(where: { $0 is PickerFormField }) else {
            return
        }
        
        if var pickerFormField = formFields[index] as? PickerFormField,
           let values = pickerFormField.values as? [Species] {
            pickerFormField.value = values.first?.rawValue
            formFields[index] = pickerFormField
        }
    }
    
    // func to set the selected row in the picker view based on the value in the picker form field
    func setPickerViewSelectedRow(for formField: FormField) {
        guard let index = formFields.firstIndex(where: { $0 is PickerFormField }) else {
            return
        }
        
        if var pickerFormField = formFields[index] as? PickerFormField,
           let values = pickerFormField.values as? [Species] {
            if let value = pickerFormField.value as? String,
               let selectedRow = values.firstIndex(where: { $0.rawValue == value }) {
                pickerFormField.selected = selectedRow
                formFields[index] = pickerFormField
            }
        }
    }
}


// MARK: - UIPickerViewDelegate

extension FormView: UIPickerViewDelegate {
    
    // func to update the value of the picker form field when the user selects a row in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let index = formFields.firstIndex(where: { $0 is PickerFormField }) else {
            return
        }
        
        if var pickerFormField = formFields[index] as? PickerFormField {
            if let values = pickerFormField.values as? [Species] {
                pickerFormField.value = values[row].rawValue
            }
            
            formFields[index] = pickerFormField
            
            delegate?.formDidUpdateValue(row, forField: pickerFormField)
        }
    }
    
}
