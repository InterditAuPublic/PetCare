//
//  Animal.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import Foundation

struct Animal: Codable {
    var id: String?
    var identifier: String? // I-CAD number
    var name: String?
    var sexe: Bool?
    var species: Species?
    var breed: String?
    var birthdate: Date?
    var weight: String?
    var color: String?
    var comments: String?
    var image: String?
    
    var Appoitements: [Appointement]?
}

enum Species: String, CaseIterable, Codable {
    case dog = "Dog"
    case cat = "Cat"
    
    var text: String {
        switch self {
        case .dog:
            return NSLocalizedString("dog", comment: "")
        case .cat:
            return NSLocalizedString("cat", comment: "")
        }
    }
}
