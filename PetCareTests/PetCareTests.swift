//
//  PetCareTests.swift
//  PetCareTests
//
//  Created by Melvin Poutrel on 05/01/2024.
//

import XCTest
import SwiftyMocky
@testable import PetCare

final class PetCareTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Exemple SwiftyMocky
    
    func testBlablaProtocol() {
        let Bla = BlablaMock()
        
        Bla.given(.returnColorIsBlue(willReturn: true))
        
        Bla.verify(.returnColorIsBlue(), count:1)
    }
    
    func testSpeciesText() {
        XCTAssertEqual(Species.dog.text, "dog")
        XCTAssertEqual(Species.cat.text, "cat")
    }
    
    func testAnimalProperties() {
        let animal = Animal(id: "1",
                            identifier: "123456789",
                            name: "Buddy",
                            sexe: true,
                            species: .dog,
                            breed: "Golden Retriever",
                            birthdate: Date(timeIntervalSince1970: 946684800), // January 1, 2000
                            weight: "20 kg",
                            color: "Golden",
                            comments: "Friendly and active",
                            image: "buddy.jpg",
                            Appoitements: nil)
        
        XCTAssertEqual(animal.id, "1")
        XCTAssertEqual(animal.identifier, "123456789")
        XCTAssertEqual(animal.name, "Buddy")
        XCTAssertEqual(animal.sexe, true)
        XCTAssertEqual(animal.species, .dog)
        XCTAssertEqual(animal.breed, "Golden Retriever")
        XCTAssertEqual(animal.birthdate, Date(timeIntervalSince1970: 946684800))
        XCTAssertEqual(animal.weight, "20 kg")
        XCTAssertEqual(animal.color, "Golden")
        XCTAssertEqual(animal.comments, "Friendly and active")
        XCTAssertEqual(animal.image, "buddy.jpg")
        XCTAssertNil(animal.Appoitements)
    }
    
    
    
    func testVeterinarianProperties() {
            let veterinarian = Veterinarian(id: "1",
                                            name: "Dr. Smith",
                                            address: "123 Main Street",
                                            zipcode: "12345",
                                            city: "City",
                                            country: "Country",
                                            phone: "123-456-7890",
                                            email: "drsmith@example.com",
                                            note: "Lorem ipsum dolor sit amet",
                                            Appointements: nil)
            
            XCTAssertEqual(veterinarian.id, "1")
            XCTAssertEqual(veterinarian.name, "Dr. Smith")
            XCTAssertEqual(veterinarian.address, "123 Main Street")
            XCTAssertEqual(veterinarian.zipcode, "12345")
            XCTAssertEqual(veterinarian.city, "City")
            XCTAssertEqual(veterinarian.country, "Country")
            XCTAssertEqual(veterinarian.phone, "123-456-7890")
            XCTAssertEqual(veterinarian.email, "drsmith@example.com")
            XCTAssertEqual(veterinarian.note, "Lorem ipsum dolor sit amet")
            XCTAssertNil(veterinarian.Appointements)
        }
    
    func testAppointmentProperties() {
        let appointment = Appointement(id: "1",
                                      date: Date(),
                                      descriptionRdv: "Routine checkup",
                                      animals: nil,
                                      veterinarian: nil)
        
        XCTAssertEqual(appointment.id, "1")
        XCTAssertNotNil(appointment.date)
        XCTAssertEqual(appointment.descriptionRdv, "Routine checkup")
        XCTAssertNil(appointment.animals)
        XCTAssertNil(appointment.veterinarian)
    }
    
    
}
