//
//  Veterinarian.swift
//  PetCare
//
//  Created by Melvin Poutrel on 15/01/2024.
//

import Foundation

struct Veterinarian: Codable {
    var id: String
    var name: String!
    var address: String!
    var zipcode: String!
    var city: String!
    var phone: String?
    var email: String?
    var note: String?
    
    var appointements: [Appointment]?
}

