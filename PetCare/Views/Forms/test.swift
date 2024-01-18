//
//  test.swift
//  PetCare
//
//  Created by Melvin Poutrel on 18/01/2024.
//

import Foundation

public protocol QTextFieldType {
    var placeholder: String { get }
    var inputType: QTextFieldInputType { get }
}

public enum QTextFieldInputType {
    case keyboard
    case datePicker(minDate: Date? = nil, maxDate: Date? = nil)
}

public protocol QTextFieldCellDelegate: AnyObject {
    func didUpdate(value: Any?, for type: QTextFieldType)
    func textFieldOnUpdate(value: String?, for type: QTextFieldType) -> String?
}

public extension QTextFieldCellDelegate {
    func textFieldOnUpdate(value: String?, for type: QTextFieldType) -> String? {
        return value
    }
}
