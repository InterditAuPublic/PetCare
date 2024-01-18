//
//  VeterinarianForm.swift
//  PetCare
//
//  Created by Melvin Poutrel on 15/01/2024.
//

import UIKit

class VeterinarianForm: FormView, FormDelegate {
    
    
    var _veto: Veterinarian?
    
    init(veto: Veterinarian?) {
        super.init(formFields: [])
        self._veto = veto
        setupForm()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupForm() {
        
        delegate = self
    }
    
    func getFormFields() -> [FormField] {
        return formFields
    }
    
    func formDidUpdateValue(_ value: Any?, forField field: FormField) {
       
    }
}


