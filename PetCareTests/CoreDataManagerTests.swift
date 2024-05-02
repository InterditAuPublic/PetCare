//
//  CoreDataManagerTests.swift
//  PetCareTests
//
//  Created by Melvin Poutrel on 02/05/2024.
//

import XCTest
@testable import PetCare

final class CoreDataManagerTests: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataManager = CoreDataManager.shared
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        coreDataManager.deleteAllAnimals()
    }
    
    // Test saving an animal
    func testSaveAnimal() {
        // Test saving an animal
        let animal = Animal(id: "1",
                            identifier: "123456789",
                            name: "Buddy",
                            sexe: true,
                            species: .dog,
                            breed: "Golden Retriever",
                            birthdate: Date(),
                            weight: "20 kg",
                            color: "Golden",
                            comments: "Friendly and active",
                            image: nil,
                            Appoitements: nil)
        coreDataManager.saveAnimal(animal: animal)
        
        // Verify if the animal is saved
        let fetchedAnimals = coreDataManager.fetchAnimals()
        XCTAssertNotNil(fetchedAnimals)
        XCTAssertEqual(fetchedAnimals?.count, 1)
        XCTAssertEqual(fetchedAnimals?.first?.name, "Buddy")
    }
    
    // Test updating an animal
    func testUpdateAnimal() {
        // Update the name of the animal
        let fetchedAnimals = coreDataManager.fetchAnimals()
        if var updatedAnimal = fetchedAnimals?.first {
            updatedAnimal.name = "Max"
            coreDataManager.updateAnimal(animal: updatedAnimal)
            
            // Verify if the animal is correctly updated
            let fetchedUpdatedAnimal = coreDataManager.fetchAnimals()?.first
            XCTAssertEqual(fetchedUpdatedAnimal?.name, "Max")
        }
    }
    
    // Test deleting an animal
    func testDeleteAnimal() {
        // Delete the animal
        if let animalToDelete = coreDataManager.fetchAnimals()?.first {
            coreDataManager.deleteAnimal(animal: animalToDelete)
            
            // Verify if the animal is correctly deleted
            let fetchedAnimalsAfterDeletion = coreDataManager.fetchAnimals()
            XCTAssertEqual(fetchedAnimalsAfterDeletion?.count, 0)
        }
    }
    
    func testDeleteAnimals() {
        // Fetch all animals
        guard let animals = coreDataManager.fetchAnimals() else {
            XCTFail("Failed to fetch animals")
            return
        }
        
        // Delete each animal
        for animal in animals {
            coreDataManager.deleteAnimal(animal: animal)
        }
        
        // Verify if all animals are correctly deleted
        let fetchedAnimalsAfterDeletion = coreDataManager.fetchAnimals()
        XCTAssertEqual(fetchedAnimalsAfterDeletion?.count, 0)
    }

}
