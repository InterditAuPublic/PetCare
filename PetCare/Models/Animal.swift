//
//  Animal.swift
//  PetCare
//
//  Created by Melvin Poutrel on 08/01/2024.
//

import Foundation

struct Animal: Codable {
    var id: Int?
    var identifier: String? // I-CAD number
    var name: String?
    var sexe: String?
    var species: Species?
    var breed: String?
    var birthDate: Date?
    var weight: Double?
    var height: Double?
    var color: String?
    var veterinarianID: Int?
    var lastVisit: Date?
    var alergies: String?
    var comments: String?
    var image: String?
}

enum Species: String, CaseIterable, Codable {
    case dog = "Chien"
    case cat = "Chat"
    case rabbit = "Lapin"
    case ferret = "Furet"
    case hamster = "Hamster"
    case mouse = "Souris"
    case rat = "Rat"
    case chinchilla = "Chinchilla"
    case turtle = "Tortue"
    case lizard = "Lézard"
    case snake = "Serpent"
    case bird = "Oiseau"
    case fish = "Poisson"
    case other = "Autre"
    
    // Propriété calculée pour obtenir une liste de toutes les espèces
    static var allSpecies: [Species] {
        return self.allCases
    }
}
