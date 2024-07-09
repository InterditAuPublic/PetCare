//
//  AppointmentForm.swift
//  PetCare
//
//  Created by Melvin Poutrel on 17/03/2024.
//

import Foundation

struct AppointmentForm {
    var id: String?
    var date: Date
    var descriptionRdv: String?
    var veterinarian: Veterinarian
    var animals: [Animal]
}
