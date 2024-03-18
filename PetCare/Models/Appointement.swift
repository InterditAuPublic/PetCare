//
//  Appointement.swift
//  PetCare
//
//  Created by Melvin Poutrel on 23/01/2024.
//

import Foundation

struct Appointement: Codable {
    var id: String?
    var date: Date?
    var descriptionRdv: String?
    var animals: [Animal]?
    var veterinarian: Veterinarian?
}
