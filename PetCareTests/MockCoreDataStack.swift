//
//  MockCoreDataStack.swift
//  PetCareTests
//
//  Created by Melvin Poutrel on 23/05/2024.
//

import Foundation
import CoreData
@testable import PetCare

class MockCoreDataStack: CoreDataStack {
    override init() {
        super.init()

        let container = NSPersistentContainer(name: "PetCare")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.persistentContainer = container
    }
}
