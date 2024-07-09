//
//  VeterinarianManagementTests.swift
//  PetCareTests
//
//  Created by Melvin Poutrel on 09/06/2024.
//

import XCTest
import CoreData
@testable import PetCare

class VeterinarianManagementTests: XCTestCase {
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
    
    func testSaveVeterinarian() {
        let veterinarianForm = VeterinarianForm(
            id: nil,
            name: "Dr. Smith",
            address: "123 Animal St",
            zipcode: "12345",
            city: "Pet City",
            phone: "123-456-7890",
            email: "drsmith@petcare.com",
            note: "Specialist in exotic animals"
        )
        
        coreDataManager.saveVeterinarian(form: veterinarianForm)

        // Fetch the saved veterinarian to get its ID
        guard let savedVeterinarian = coreDataManager.fetchVeterinarians()?.first else {
            XCTFail("Failed to fetch the initially saved veterinarian")
            return
        }
        
        XCTAssertEqual(savedVeterinarian.name, "Dr. Smith", "Veterinarian's name should be Dr. Smith")
        XCTAssertEqual(savedVeterinarian.address, "123 Animal St", "Veterinarian's address should be 123 Animal St")
        XCTAssertEqual(savedVeterinarian.zipcode, "12345", "Veterinarian's zipcode should be 12345")
        XCTAssertEqual(savedVeterinarian.city, "Pet City", "Veterinarian's city should be Pet City")
        XCTAssertEqual(savedVeterinarian.phone, "123-456-7890", "Veterinarian's phone should be 123-456-7890")
        
        coreDataManager.deleteVeterinarian(veterinarian: savedVeterinarian)    
    }
    
    func testUpdateVeterinarian_Success() {
        // Setup initial veterinarian
        let initialVeterinarianForm = VeterinarianForm(
            name: "Dr. Smith",
            address: "123 Animal St",
            zipcode: "12345",
            city: "Pet City",
            phone: "123-456-7890",
            email: "drsmith@petcare.com",
            note: "Specialist in exotic animals"
        )

        coreDataManager.saveVeterinarian(form: initialVeterinarianForm)

        // Fetch the saved veterinarian to get its ID
        guard let savedVeterinarian = coreDataManager.fetchVeterinarians()?.first else {
            XCTFail("Failed to fetch the initially saved veterinarian")
            return
        }

        // Create an update form
        let updateVeterinarianForm = VeterinarianForm(
            id: savedVeterinarian.id,
            name: "Dr. Smith",
            address: "456 Animal Rd",
            zipcode: "54321",
            city: "Pet Town",
            phone: "098-765-4321",
            email: "updateemail@petcare.com",
            note: "Updated note"
        )

        // Attempt to update the veterinarian
        coreDataManager.updateVeterinarian(form: updateVeterinarianForm)

        // Fetch the veterinarians from the core data manager
        let veterinarians = coreDataManager.fetchVeterinarians()

        // Assert that the veterinarian was updated
        guard let updatedVeterinarian = veterinarians?.first else {
            XCTFail("Failed to fetch the veterinarian after update attempt")
            return
        }

        XCTAssertEqual(updatedVeterinarian.name, "Dr. Smith", "Veterinarian's name should not be updated")
        XCTAssertEqual(updatedVeterinarian.address, "456 Animal Rd", "Veterinarian's address should be updated")
        XCTAssertEqual(updatedVeterinarian.zipcode, "54321", "Veterinarian's zipcode should be updated")
        XCTAssertEqual(updatedVeterinarian.city, "Pet Town", "Veterinarian's city should be updated")
        XCTAssertEqual(updatedVeterinarian.phone, "098-765-4321", "Veterinarian's phone should be updated")
        XCTAssertEqual(updatedVeterinarian.email, "updateemail@petcare.com", "Veterinarian's email should be updated")
        XCTAssertEqual(updatedVeterinarian.note, "Updated note", "Veterinarian's note should be updated")

        coreDataManager.deleteVeterinarian(veterinarian: updatedVeterinarian)

        }

    func testUpdateVeterinarian_Failure_InvalidID() {
        // Setup initial veterinarian
        let initialVeterinarianForm = VeterinarianForm(
            name: "Dr. Smith",
            address: "123 Animal St",
            zipcode: "12345",
            city: "Pet City",
            phone: "123-456-7890",
            email: "",
            note: "Specialist in exotic animals"
        )

        coreDataManager.saveVeterinarian(form: initialVeterinarianForm)

        // Fetch the saved veterinarian to get its ID
        guard var savedVeterinarian = coreDataManager.fetchVeterinarians()?.first else {
            XCTFail("Failed to fetch the initially saved veterinarian")
            return
        }

        savedVeterinarian.id = "ASDASDASDASD"

        // Create an update form
        let updateVeterinarianForm = VeterinarianForm(
            id: savedVeterinarian.id,
            name: "Dr. Smith",
            address: "456 Animal Rd",
            zipcode: "54321",
            city: "Pet Town",
            phone: "098-765-4321",
            email: "",
            note: "Updated note"
        )

        // Attempt to update the veterinarian
        coreDataManager.updateVeterinarian(form: updateVeterinarianForm)

        // Fetch the veterinarians from the core data manager
        let veterinarians = coreDataManager.fetchVeterinarians()

        // Assert that the veterinarian was not updated
        guard let updatedVeterinarian = veterinarians?.first else {
            XCTFail("Failed to fetch the veterinarian after update attempt")
            return
        }

        XCTAssertEqual(updatedVeterinarian.name, "Dr. Smith", "Veterinarian's name should not be updated when the ID is invalid")
        XCTAssertEqual(updatedVeterinarian.address, "123 Animal St", "Veterinarian's address should not be updated when the ID is invalid")
    }

    func testDeleteVeterinarian_Success() {
        // Setup initial veterinarian
        let initialVeterinarianForm = VeterinarianForm(
            id: nil,
            name: "Dr. Smith",
            address: "123 Animal St",
            zipcode: "12345",
            city: "Pet City",
            phone: "123-456-7890",
            email: "",
            note: "Specialist in exotic animals"
        )

        coreDataManager.saveVeterinarian(form: initialVeterinarianForm)

        // Fetch the saved veterinarian to get its ID
        guard let savedVeterinarian = coreDataManager.fetchVeterinarians()?.first else {
            XCTFail("Failed to fetch the initially saved veterinarian")
            return
        }

        // Delete the veterinarian
        coreDataManager.deleteVeterinarian(veterinarian: savedVeterinarian)

        // Fetch the veterinarians from the core data manager
        let veterinarians = coreDataManager.fetchVeterinarians()

        // Assert that the veterinarian was deleted 
        XCTAssertEqual(veterinarians?.count, 0, "Veterinarians count should be 0")
    }

    
    func testDeleteVeterinarian_Failure() {
        // Setup initial veterinarian
        let initialVeterinarianForm = VeterinarianForm(
            id: nil,
            name: "Dr. Smith",
            address: "123 Animal St",
            zipcode: "12345",
            city: "Pet City",
            phone: "123-456-7890",
            email: "drsmith@petcare.com",
            note: "Specialist in exotic animals"
        )
        
        coreDataManager.saveVeterinarian(form: initialVeterinarianForm)
        
        // Fetch the saved veterinarian to get its ID
        guard var savedVeterinarian = coreDataManager.fetchVeterinarians()?.first else {
            XCTFail("Failed to fetch the initially saved veterinarian")
            return
        }
        
        savedVeterinarian.id = "ASDASDASDASD"
        
        // Delete the veterinarian
        coreDataManager.deleteVeterinarian(veterinarian: savedVeterinarian)
        
        // Fetch the veterinarians from the core data manager
        let veterinarians = coreDataManager.fetchVeterinarians()
        
        // Assert that the veterinarian was not deleted
        XCTAssertEqual(veterinarians?.count, 1, "Veterinarians count should be 1")

        coreDataManager.deleteVeterinarian(veterinarian: savedVeterinarian)
    }

    func testFetchVeterinarians() {
        // Setup initial veterinarian
        let initialVeterinarianForm = VeterinarianForm(
            id: nil,
            name: "Dr. Smith",
            address: "123 Animal St",
            zipcode: "12345",
            city: "Pet City",
            phone: "123-456-7890",
            email: "",
            note: "Specialist in exotic animals"
        )

        coreDataManager.saveVeterinarian(form: initialVeterinarianForm)

        // Fetch the saved veterinarians
        let veterinarians = coreDataManager.fetchVeterinarians()

        // Assert that the veterinarians were fetched
        XCTAssertNotNil(veterinarians, "Veterinarians should not be nil")
        XCTAssertEqual(veterinarians?.count, 1, "Veterinarians count should be 1")

        coreDataManager.deleteVeterinarian(veterinarian: veterinarians!.first!)
    }

    func testFetchVeterinarian() {
        // Setup initial veterinarian
        let initialVeterinarianForm = VeterinarianForm(
            id: nil,
            name: "Dr. Smith",
            address: "123 Animal St",
            zipcode: "12345",
            city: "Pet City",
            phone: "123-456-7890",
            email: "",
            note: "Specialist in exotic animals"
        )

        coreDataManager.saveVeterinarian(form: initialVeterinarianForm)

        // Fetch the saved veterinarian to get its ID
        guard let savedVeterinarian = coreDataManager.fetchVeterinarians()?.first else {
            XCTFail("Failed to fetch the initially saved veterinarian")
            return
        }
            
        // Fetch the veterinarian by ID
        let fetchedVeterinarian = coreDataManager.fetchVeterinarian(byId: savedVeterinarian.id)

        // Assert that the veterinarian was fetched
        XCTAssertNotNil(fetchedVeterinarian, "Veterinarian should not be nil")
        XCTAssertEqual(fetchedVeterinarian?.id, savedVeterinarian.id, "Veterinarian ID should match the saved veterinarian ID")

        coreDataManager.deleteVeterinarian(veterinarian: savedVeterinarian)
    }

    func testFetchVeterinarian_Nil() {
        // Fetch the veterinarian by ID
            let fetchedVeterinarian = coreDataManager.fetchVeterinarian(byId: "ASDASDASDASD")

        // Assert that the veterinarian was not fetched
        XCTAssertNil(fetchedVeterinarian, "Veterinarian should be nil")
    }
}

        
