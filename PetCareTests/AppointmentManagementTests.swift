//
//  AppointmentManagementTests.swift
//  PetCareTests
//
//  Created by Melvin Poutrel on 20/06/2024.
//
import XCTest
import CoreData
@testable import PetCare

class AppointmentManagerTests: XCTestCase {

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
    
    func testSaveAppointment() {
       
        // Given
        let veterinarian = Veterinarian(id: "vet1", name: "Dr. Vet", address: "123 Vet St", zipcode: "12345", city: "VetCity", phone: "1234567890", email: "vet@example.com", note: "Note")
        let animal = Animal(id: "animal1", identifier: "A123", name: "Buddy", sexe: true, sterilized: false, species: .dog, breed: "Golden Retriever", birthdate: Date(), weight: 30.0, color: "Golden", comments: "Friendly")
        let appointmentForm = AppointmentForm(date: Date(), descriptionRdv: "Checkup", veterinarian: veterinarian, animals: [animal])
        
        coreDataManager.saveAppointment(form: appointmentForm)
    
        let appointments = coreDataManager.fetchAppointments()
        XCTAssertNotNil(appointments)
        XCTAssertEqual(appointments?.count, 1)
    }
    
    func testFetchAppointments() {
        // Given
        let veterinarian = Veterinarian(id: "vet1", name: "Dr. Vet", address: "123 Vet St", zipcode: "12345", city: "VetCity", phone: "1234567890", email: "vet@example.com", note: "Note")
        let animal = Animal(id: "animal1", identifier: "A123", name: "Buddy", sexe: true, sterilized: false, species: .dog, breed: "Golden Retriever", birthdate: Date(), weight: 30.0, color: "Golden", comments: "Friendly")
        let appointmentForm = AppointmentForm(date: Date(), descriptionRdv: "Checkup", veterinarian: veterinarian, animals: [animal])
        
        coreDataManager.saveAppointment(form: appointmentForm)
        
        // When
        let fetchedAppointments = coreDataManager.fetchAppointments()
        
        // Then
        XCTAssertNotNil(fetchedAppointments)
        XCTAssertEqual(fetchedAppointments?.count, 1)
    }
    
    func testUpdateAppointment() {
        // Given
        let veterinarian = Veterinarian(id: "vet1", name: "Dr. Vet", address: "123 Vet St", zipcode: "12345", city: "VetCity", phone: "1234567890", email: "vet@example.com", note: "Note")
        let animal = Animal(id: "animal1", identifier: "A123", name: "Buddy", sexe: true, sterilized: false, species: .dog, breed: "Golden Retriever", birthdate: Date(), weight: 30.0, color: "Golden", comments: "Friendly")
        let appointmentForm = AppointmentForm(date: Date(), descriptionRdv: "Checkup", veterinarian: veterinarian, animals: [animal])
        
        coreDataManager.saveAppointment(form: appointmentForm)
        
        var fetchedAppointments = coreDataManager.fetchAppointments()
        guard let appointmentToUpdate = fetchedAppointments?.first else {
            XCTFail("Failed to fetch appointment")
            return
        }
        
        // When
        let updatedForm = AppointmentForm(id: appointmentToUpdate.id, date: Date(), descriptionRdv: "Updated Checkup", veterinarian: veterinarian, animals: [animal])
        coreDataManager.updateAppointment(appointment: updatedForm)
        
        // Then
        fetchedAppointments = coreDataManager.fetchAppointments()
        XCTAssertEqual(fetchedAppointments?.first?.descriptionRdv, "Updated Checkup")
    }
    
    func testDeleteAppointment() {
        // Given
        let veterinarian = Veterinarian(id: "vet1", name: "Dr. Vet", address: "123 Vet St", zipcode: "12345", city: "VetCity", phone: "1234567890", email: "vet@example.com", note: "Note")
        let animal = Animal(id: "animal1", identifier: "A123", name: "Buddy", sexe: true, sterilized: false, species: .dog, breed: "Golden Retriever", birthdate: Date(), weight: 30.0, color: "Golden", comments: "Friendly")
        let appointmentForm = AppointmentForm(date: Date(), descriptionRdv: "Checkup", veterinarian: veterinarian, animals: [animal])
        
        coreDataManager.saveAppointment(form: appointmentForm)
        
        var fetchedAppointments = coreDataManager.fetchAppointments()
        guard let appointmentToDelete = fetchedAppointments?.first else {
            XCTFail("Failed to fetch appointment")
            return
        }
        
        // When
        coreDataManager.deleteAppointment(appointment: appointmentToDelete)
        
        // Then
        fetchedAppointments = coreDataManager.fetchAppointments()
        XCTAssertEqual(fetchedAppointments?.count, 0)
    }
    
    func testFetchAppointmentsSortedByDate() {
        // Given
        let veterinarian = Veterinarian(id: "vet1", name: "Dr. Vet", address: "123 Vet St", zipcode: "12345", city: "VetCity", phone: "1234567890", email: "vet@example.com", note: "Note")
        let animal = Animal(id: "animal1", identifier: "A123", name: "Buddy", sexe: true, sterilized: false, species: .dog, breed: "Golden Retriever", birthdate: Date(), weight: 30.0, color: "Golden", comments: "Friendly")
        
        let pastDate = Date().addingTimeInterval(-3600) // 1 hour ago
        let futureDate = Date().addingTimeInterval(3600) // 1 hour from now
        
        let pastAppointmentForm = AppointmentForm(date: pastDate, descriptionRdv: "Past Checkup", veterinarian: veterinarian, animals: [animal])
        let futureAppointmentForm = AppointmentForm(date: futureDate, descriptionRdv: "Future Checkup", veterinarian: veterinarian, animals: [animal])
        
        coreDataManager.saveAppointment(form: pastAppointmentForm)
        coreDataManager.saveAppointment(form: futureAppointmentForm)
        
        // When
        let sortedAppointments = coreDataManager.fetchAppointmentsSortedByDate()
        
        // Then
        XCTAssertEqual(sortedAppointments?.count, 2)
        XCTAssertEqual(sortedAppointments?.first?.descriptionRdv, "Past Checkup")
        XCTAssertEqual(sortedAppointments?.last?.descriptionRdv, "Future Checkup")
    }
    
    func testFetchUpcomingAppointmentsSortedByDate() {
        // Given
        let veterinarian = Veterinarian(id: "vet1", name: "Dr. Vet", address: "123 Vet St", zipcode: "12345", city: "VetCity", phone: "1234567890", email: "vet@example.com", note: "Note")
        let animal = Animal(id: "animal1", identifier: "A123", name: "Buddy", sexe: true, sterilized: false, species: .dog, breed: "Golden Retriever", birthdate: Date(), weight: 30.0, color: "Golden", comments: "Friendly")
        
        let pastDate = Date().addingTimeInterval(-3600) // 1 hour ago
        let futureDate1 = Date().addingTimeInterval(3600) // 1 hour from now
        let futureDate2 = Date().addingTimeInterval(7200) // 2 hours from now
        
        let pastAppointmentForm = AppointmentForm(date: pastDate, descriptionRdv: "Past Checkup", veterinarian: veterinarian, animals: [animal])
        let futureAppointmentForm1 = AppointmentForm(date: futureDate1, descriptionRdv: "Future Checkup 1", veterinarian: veterinarian, animals: [animal])
        let futureAppointmentForm2 = AppointmentForm(date: futureDate2, descriptionRdv: "Future Checkup 2", veterinarian: veterinarian, animals: [animal])
        
        coreDataManager.saveAppointment(form: pastAppointmentForm)
        coreDataManager.saveAppointment(form: futureAppointmentForm1)
        coreDataManager.saveAppointment(form: futureAppointmentForm2)
        
        // When
        let sortedAppointments = coreDataManager.fetchUpcomingAppointmentsSortedByDate()
        
        // Then
        XCTAssertEqual(sortedAppointments?.count, 2)
        XCTAssertEqual(sortedAppointments?.first?.descriptionRdv, "Future Checkup 1")
        XCTAssertEqual(sortedAppointments?.last?.descriptionRdv, "Future Checkup 2")
    }
}
