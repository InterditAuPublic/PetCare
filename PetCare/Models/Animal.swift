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
//    var sexe: Sexe?
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
    case dog = "Dog"
    case cat = "Cat"
    case rabbit = "Rabbit"
    case ferret = "Ferret"
    case hamster = "Hamster"
    case mouse = "Mouse"
    case rat = "Rat"
    case chinchilla = "Chinchilla"
    case turtle = "Turttle"
    case lizard = "Liard"
    case snake = "Snake"
    case bird = "Bird"
    case fish = "Fish"
    case other = "Other"
    
    // Propriété calculée pour obtenir une liste de toutes les espèces
    static var allSpecies: [Species] {
        return self.allCases
    }
}


//enum Sexe: String, CaseIterable, Codable {
//    case male = "Male"
//    case female = "Female"
//
//    static var allSexe: [Sexe] {
//        return self.allCases
//    }
//}
