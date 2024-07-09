//
//  AnimalManagementTests.swift
//  PetCareTests
//
//  Created by Melvin Poutrel on 05/01/2024.
//

import XCTest
import CoreData
@testable import PetCare

class AnimalManagementTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var mockCoreDataStack: MockCoreDataStack!
    
    override func setUp() {
        super.setUp()
        mockCoreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: mockCoreDataStack)
    }
    
    override func tearDown() {
        mockCoreDataStack = nil
        coreDataManager = nil
        super.tearDown()
    }
    
    // MARK: - Animal Tests
    
    // Test the saveAnimal method of the CoreDataManager succeds
    func testSaveAnimal() throws {
        let animalForm = AnimalForm(id: UUID().uuidString, identifier: "123", name: "Rex", sexe: false, sterilized: false, species: .dog, breed: "Labrador", birthdate: Date(), weight: 30, color: "Brown", comments: "Friendly", image: nil)
        coreDataManager.saveAnimal(form: animalForm)

        let fetchedAnimal = coreDataManager.fetchAnimal(byId: animalForm.id!)
        XCTAssertNotNil(fetchedAnimal)
        XCTAssertEqual(fetchedAnimal?.identifier, "123")
        XCTAssertEqual(fetchedAnimal?.name, "Rex")
    }

    // Test the updateAnimal method of the CoreDataManager succeds
    func testUpdateAnimal_Success() {
        let animalForm = AnimalForm(
            identifier: "123",
            name: "Rex",
            sexe: true,
            sterilized: true,
            species: .dog,
            breed: "Labrador",
            birthdate: Date(),
            weight: 10.0,
            color: "Brown",
            comments: "Friendly dog",
            image: nil
        )

        coreDataManager.saveAnimal(form: animalForm)

        let animal = coreDataManager.fetchAnimals()?.first
        XCTAssertEqual(animal?.identifier, "123")
        XCTAssertEqual(animal?.name, "Rex")
        XCTAssertEqual(animal?.sexe, true)
        XCTAssertEqual(animal?.species, .dog)
        XCTAssertEqual(animal?.breed, "Labrador")
        XCTAssertEqual(animal?.weight, 10.0)
        XCTAssertEqual(animal?.color, "Brown")
        XCTAssertEqual(animal?.comments, "Friendly dog")

        let updatedAnimalForm = AnimalForm(
            id: animal!.id,
            identifier: "456",
            name: "Max",
            sexe: false,
            sterilized: false,
            species: .cat,
            breed: "Siamese",
            birthdate: Date(),
            weight: 5.0,
            color: "White",
            comments: "Shy cat",
            image: nil
        )

        coreDataManager.updateAnimal(form: updatedAnimalForm)

        let updatedAnimal = coreDataManager.fetchAnimals()?.first
        XCTAssertEqual(updatedAnimal?.identifier, "456")
        XCTAssertEqual(updatedAnimal?.name, "Max")
        XCTAssertEqual(updatedAnimal?.sexe, false)
        XCTAssertEqual(updatedAnimal?.species, .cat)
        XCTAssertEqual(updatedAnimal?.breed, "Siamese")
        XCTAssertEqual(updatedAnimal?.weight, 5.0)
        XCTAssertEqual(updatedAnimal?.color, "White")
        XCTAssertEqual(updatedAnimal?.comments, "Shy cat")

        coreDataManager.deleteAnimal(animal: updatedAnimal!)
    }

    // Test the deleteAnimal method of the CoreDataManager succeds
    func testDeleteAnimal_Success() {
        let animalForm = AnimalForm(
            identifier: "123",
            name: "Rex",
            sexe: true,
            sterilized: false,
            species: .dog,
            breed: "Labrador",
            birthdate: Date(),
            weight: 10.0,
            color: "Brown",
            comments: "Friendly dog",
            image: nil
        )

        coreDataManager.saveAnimal(form: animalForm)

        let animal = coreDataManager.fetchAnimals()?.first
        XCTAssertEqual(animal?.identifier, "123")
        XCTAssertEqual(animal?.name, "Rex")
        XCTAssertEqual(animal?.sexe, true)
        XCTAssertEqual(animal?.species, .dog)
        XCTAssertEqual(animal?.breed, "Labrador")
        XCTAssertEqual(animal?.weight, 10.0)
        XCTAssertEqual(animal?.color, "Brown")
        XCTAssertEqual(animal?.comments, "Friendly dog")

        coreDataManager.deleteAnimal(animal: animal!)

        let deletedAnimal = coreDataManager.fetchAnimals()?.first
        XCTAssertNil(deletedAnimal)
    }

    // Test the deleteAnimal method of the CoreDataManager fails
    func testDeleteAnimal_Failure() {
        let animalForm = AnimalForm(
            id: "AZERTYUIOPMLKJHGFDSQ",
            identifier: "123",
            name: "Rex",
            sexe: true,
            sterilized: false,
            species: .dog,
            breed: "Labrador",
            birthdate: Date(),
            weight: 10.0,
            color: "Brown",
            comments: "Friendly dog",
            image: nil
        )

        coreDataManager.saveAnimal(form: animalForm)
        
        var animal = coreDataManager.fetchAnimals()?.first

        animal?.id = "QWERTYUIOPMLKJHGFDSQ"

        coreDataManager.deleteAnimal(animal: animal!)

        let animals = coreDataManager.fetchAnimals()
        XCTAssertEqual(animals?.count, 1)
    }
   

    // Test the fetchAnimals method of the CoreDataManager succeds
    func testFetchAnimals_Success() {
        let animalForm = AnimalForm(
            identifier: "123",
            name: "Rex",
            sexe: true,
            sterilized: false,
            species: .dog,
            breed: "Labrador",
            birthdate: Date(),
            weight: 10.0,
            color: "Brown",
            comments: "Friendly dog",
            image: nil
        )

        coreDataManager.saveAnimal(form: animalForm)

        let animal = coreDataManager.fetchAnimals()?.first
        XCTAssertEqual(animal?.identifier, "123")
        XCTAssertEqual(animal?.name, "Rex")
        XCTAssertEqual(animal?.sexe, true)
        XCTAssertEqual(animal?.species, .dog)
        XCTAssertEqual(animal?.breed, "Labrador")
        XCTAssertEqual(animal?.weight, 10.0)
        XCTAssertEqual(animal?.color, "Brown")
        XCTAssertEqual(animal?.comments, "Friendly dog")

        coreDataManager.deleteAnimal(animal: animal!)
    }

    // Test the fetchAnimals method of the CoreDataManager fails
    func testFetchAnimals_Failure() {
        let animals = coreDataManager.fetchAnimals()
        XCTAssertEqual(animals?.count, 0)
    }
    
    // Test the fetchAnimal method of the CoreDataManager succeds
    func testFetchAnimalById_Success() {
        let animalForm = AnimalForm(
            identifier: "123456789",
            name: "Flamby",
            sexe: false,
            sterilized: false,
            species: .dog,
            breed: "Bichon frise",
            birthdate: Date(),
            weight: 10.0,
            color: "White",
            comments: "Very friendly dog",
            image: nil
        )

        coreDataManager.saveAnimal(form: animalForm)

        let animal = coreDataManager.fetchAnimals()?.first
        let animalId = animal?.id
        
        let fetchedAnimal = coreDataManager.fetchAnimal(byId: animalId!)
        XCTAssertEqual(fetchedAnimal?.identifier, "123456789")
        XCTAssertEqual(fetchedAnimal?.name, "Flamby")
        XCTAssertEqual(fetchedAnimal?.sexe, false)
        XCTAssertEqual(fetchedAnimal?.species, .dog)
        XCTAssertEqual(fetchedAnimal?.breed, "Bichon frise")
        XCTAssertEqual(fetchedAnimal?.weight, 10.0)
        XCTAssertEqual(fetchedAnimal?.color, "White")
        XCTAssertEqual(fetchedAnimal?.comments, "Very friendly dog")

        coreDataManager.deleteAnimal(animal: fetchedAnimal!)
    }
    
    // Test the fetchAnimal method of the CoreDataManager fails
    func testFetchAnimalById_Failure() {
        let animal = coreDataManager.fetchAnimal(byId: "QWERTYUIOPMLKJHGFDSQ")
        XCTAssertNil(animal)
    }
}
