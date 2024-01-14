import UIKit

// Define a protocol for form fields
protocol FormField {
    var labelText: String? { get set }
    var placeholder: String? { get set }
    var value: Any? { get set }
    var inputViewType: InputViewType { get }
}

// Define an enum for input view types
enum InputViewType {
    case text, date, segment, image
}

// Define a protocol for the form itself
protocol FormDelegate: AnyObject {
    func formDidUpdateValue(_ value: Any?, forField field: FormField)
}

// Implement a basic text form field conforming to FormField
struct TextFormField: FormField {
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var inputViewType: InputViewType = .text
}

// Implement a date form field conforming to FormField
struct DateFormField: FormField {
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var inputViewType: InputViewType = .date
}

// Implement a segmented control form field conforming to FormField
struct SegmentFormField: FormField {
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var segments: [String]
    var inputViewType: InputViewType = .segment
}

// Implement an image form field conforming to FormField
struct ImageFormField: FormField {
    var labelText: String?
    var placeholder: String?
    var value: Any?
    var inputViewType: InputViewType = .image
}

// Implement the main Form class
class FormView: UIStackView, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
        let segmentedControl = UISegmentedControl(items: (formField.value as? [String]) ?? [])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChange(_:)), for: .valueChanged)
        return segmentedControl
    }
    
    private func createImageView(for formField: FormField) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = formField.value as? UIImage ?? UIImage(systemName: "person.crop.circle.badge.plus")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.tintColor = .orange
        imageView.isUserInteractionEnabled = true
        return imageView
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
        print("Tapped")
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        // Present the image picker
        if let viewController = findViewController() {
            viewController.present(imagePicker, animated: true, completion: nil)
        }
                
        guard let index = formFields.firstIndex(where: { $0 is ImageFormField }) else {
            return
        }
    
        if let imageFormField = formFields[index] as? ImageFormField {
            print(sender)
            delegate?.formDidUpdateValue(sender, forField: imageFormField)
        }
    }
}
