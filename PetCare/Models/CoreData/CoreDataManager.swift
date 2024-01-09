//
//  CoreDataManager.swift
//  PetCare
//
//  Created by Melvin Poutrel on 09/01/2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {} // Private initializer to ensure it's a singleton
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetCare") // Replace "PetCare" with your actual Core Data model name
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Animal Management
    
    func saveAnimal(animal: Animal) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "AnimalSaved", in: context)! // Replace "AnimalEntity" with your actual entity name
        
        let animalObject = NSManagedObject(entity: entity, insertInto: context)
        
        // Set properties of the Core Data entity using the values from the Animal object
        animalObject.setValue(animal.identifier, forKey: "identifier")
        animalObject.setValue(animal.name, forKey: "name")
        animalObject.setValue(animal.sexe, forKey: "sexe")
        animalObject.setValue(animal.species?.rawValue, forKey: "species")
        animalObject.setValue(animal.breed, forKey: "breed")
        // Add other properties accordingly

        saveContext() // Save the changes to Core Data
    }
    
    func fetchAnimals() -> [Animal]? {
            let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest() // Replace with your actual entity name

            do {
                let animalsData = try persistentContainer.viewContext.fetch(request)
                let animals = animalsData.map { animalData in
                    return Animal(
                        identifier: animalData.identifier,
                        name: animalData.name,
                        sexe: animalData.sexe,
                        species: Species(rawValue: animalData.species ?? ""),
                        breed: animalData.breed
//                        birthDate: animalData.birthdate,
//                        weight: animalData.weight,
//                        color: animalData.color,
//                        comments: animalData.comments,
//                        image: animalData.image
                    )
                }
                return animals
            } catch {
                print("Error fetching animals: \(error)")
                return nil
            }
        }
}
