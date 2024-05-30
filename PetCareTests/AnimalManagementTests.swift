//
//  AnimalManagementTests.swift
//  PetCareTests
//
//  Created by Melvin Poutrel on 23/05/2024.
//

import XCTest
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
        coreDataManager = nil
        mockCoreDataStack = nil
        super.tearDown()
    }

    // Helper method to create a sample Animal object
    private func createSampleAnimal() -> Animal {
        return Animal(
            id: UUID().uuidString,
            identifier: "123",
            name: "Buddy",
            sexe: true,
            species: .dog,
            breed: "Golden Retriever",
            birthdate: Date(),
            weight: 30.0,
            color: "Golden",
            comments: "Friendly and active"
        )
    }

    // Helper method to create a sample Veterinarian object
    private func createSampleVeterinarian() -> Veterinarian {
        return Veterinarian(
            id: UUID().uuidString,
            name: "Dr. Smith",
            address: "123 Pet St",
            zipcode: "12345",
            city: "PetCity",
            country: "Petland",
            phone: "123-456-7890",
            email: "dr.smith@example.com",
            note: "Experienced veterinarian"
        )
    }
    
    private func createSampleAppointment(with animal: Animal?, veterinarian: Veterinarian?) -> Appointement {
        return Appointement(
            id: UUID().uuidString,
            date: Date(),
            descriptionRdv: "Regular Checkup",
            animals: animal != nil ? [animal!] : nil,
            veterinarian: veterinarian
        )
    }

    // MARK: Animals
    
    func testSaveAnimal_Success() {
        let animal = createSampleAnimal()
        
        coreDataManager.saveAnimal(animal: animal)
        
        let savedAnimals = coreDataManager.fetchAnimals()
        XCTAssertEqual(savedAnimals?.count, 1)
        XCTAssertEqual(savedAnimals?.first?.identifier, animal.identifier)
    }
    
    func testFetchAnimals_Success() {
        let animal = createSampleAnimal()
        coreDataManager.saveAnimal(animal: animal)
        
        let fetchedAnimals = coreDataManager.fetchAnimals()
        XCTAssertNotNil(fetchedAnimals)
        XCTAssertEqual(fetchedAnimals?.count, 1)
        XCTAssertEqual(fetchedAnimals?.first?.name, animal.name)
    }

    func testUpdateAnimal_Success() {
        let animal = createSampleAnimal()
        coreDataManager.saveAnimal(animal: animal)
        
        // Retrieve the UUID of the saved animal
        guard let savedAnimal = coreDataManager.fetchAnimals()?.first else {
            XCTFail("Failed to fetch saved animal")
            return
        }
        
        // Modify the animal
        var updatedAnimal = savedAnimal
        updatedAnimal.name = "Max"
        
        // Update the animal using its UUID
        coreDataManager.updateAnimal(animal: updatedAnimal)
        
        // Fetch the updated animal
        let fetchedAnimals = coreDataManager.fetchAnimals()
        XCTAssertEqual(fetchedAnimals?.first(where: { $0.identifier == animal.identifier })?.name, "Max")
    }

    
    // MARK: Veterinarians

    func testSaveVeterinarian_Success() {
        let veterinarian = createSampleVeterinarian()
        
        coreDataManager.saveVeterinarian(veterinarian: veterinarian)
        
        let savedVeterinarians = coreDataManager.fetchVeterinarians()
        XCTAssertEqual(savedVeterinarians?.count, 1)
        XCTAssertEqual(savedVeterinarians?.first?.name, veterinarian.name)
    }

    func testFetchVeterinarians_Success() {
        let veterinarian = createSampleVeterinarian()
        coreDataManager.saveVeterinarian(veterinarian: veterinarian)
        
        let fetchedVeterinarians = coreDataManager.fetchVeterinarians()
        XCTAssertNotNil(fetchedVeterinarians)
        XCTAssertEqual(fetchedVeterinarians?.count, 1)
        XCTAssertEqual(fetchedVeterinarians?.first?.name, veterinarian.name)
    }

    func testUpdateVeterinarian_Success() {
        let veterinarian = createSampleVeterinarian()
        coreDataManager.saveVeterinarian(veterinarian: veterinarian)
        
        // Retrieve the UUID of the saved veterinarian
        guard let savedVeterinarian = coreDataManager.fetchVeterinarians()?.first else {
            XCTFail("Failed to fetch saved veterinarian")
            return
        }
        
        // Modify the veterinarian
        var updatedVeterinarian = savedVeterinarian
        updatedVeterinarian.name = "Dr. Brown"
        
        // Update the veterinarian using its UUID
        coreDataManager.updateVeterinarian(veterinarian: updatedVeterinarian)
        
        // Fetch the updated veterinarian
        let fetchedVeterinarians = coreDataManager.fetchVeterinarians()
        XCTAssertEqual(fetchedVeterinarians?.first(where: { $0.id == savedVeterinarian.id })?.name, "Dr. Brown")
    }

    // MARK: - Appointment Tests
   func testSaveAppointment_Success() {
       let animal = createSampleAnimal()
       coreDataManager.saveAnimal(animal: animal)

       let veterinarian = createSampleVeterinarian()
       coreDataManager.saveVeterinarian(veterinarian: veterinarian)

       let appointment = createSampleAppointment(with: animal, veterinarian: veterinarian)
       coreDataManager.saveAppointement(appointment: appointment)

       let savedAppointments = coreDataManager.fetchAppointements()
       XCTAssertEqual(savedAppointments?.count, 1)
       XCTAssertEqual(savedAppointments?.first?.descriptionRdv, appointment.descriptionRdv)
   }

   func testSaveAppointment_WithoutVeterinarianAndAnimals_Failure() {

         let appointment = createSampleAppointment(with: nil, veterinarian: nil)
         coreDataManager.saveAppointement(appointment: appointment)
    
         let savedAppointments = coreDataManager.fetchAppointements()
         XCTAssertEqual(savedAppointments?.count, 0)
   }

   func testFetchAppointments_Success() {
       let appointment = createSampleAppointment(with: nil, veterinarian: nil)
       coreDataManager.saveAppointement(appointment: appointment)

       let fetchedAppointments = coreDataManager.fetchAppointements()
       XCTAssertNotNil(fetchedAppointments)
       XCTAssertEqual(fetchedAppointments?.count, 1)
       XCTAssertEqual(fetchedAppointments?.first?.descriptionRdv, appointment.descriptionRdv)
   }

//   func testUpdateAppointment_Success() {
//        let animal = createSampleAnimal()
//        coreDataManager.saveAnimal(animal: animal)
//
//        let veterinarian = createSampleVeterinarian()
//        coreDataManager.saveVeterinarian(veterinarian: veterinarian)
//
//        let appointment = createSampleAppointment(with: animal, veterinarian: veterinarian)
//        coreDataManager.saveAppointement(appointment: appointment)
//
//        // Retrieve the UUID of the saved appointment
//        guard let savedAppointment = coreDataManager.fetchAppointements()?.first else {
//            XCTFail("Failed to fetch saved appointment")
//            return
//        }
//
//        // Modify the appointment
//        var updatedAppointment = savedAppointment
//        updatedAppointment.descriptionRdv = "Emergency Checkup"
//
//        // Update the appointment using its UUID
//        coreDataManager.updateAppointement(appointment: updatedAppointment)
//
//        // Fetch the updated appointment
//        let fetchedAppointments = coreDataManager.fetchAppointements()
//        XCTAssertEqual(fetchedAppointments?.first(where: { $0.id == savedAppointment.id })?.descriptionRdv, "Emergency Checkup")
//   }
}
