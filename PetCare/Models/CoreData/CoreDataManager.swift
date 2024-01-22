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
    
    // Private initializer to ensure it's a singleton
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetCare")
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
        print("DANS CORE DATA \(animal)")
        
        guard !checkIfIdentifierExists(identifier: animal.identifier, entityName: "AnimalSaved") else { return }
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "AnimalSaved", in: context)!
        
        let animalObject = NSManagedObject(entity: entity, insertInto: context)
        
        // Set properties of the Core Data entity using the values from the Animal object
        animalObject.setValue(animal.identifier, forKey: "identifier")
        animalObject.setValue(animal.name, forKey: "name")
        animalObject.setValue(animal.sexe, forKey: "sexe")
        animalObject.setValue(animal.species?.rawValue, forKey: "species")
        animalObject.setValue(animal.breed, forKey: "breed")
        animalObject.setValue(animal.birthdate, forKey: "birthdate")
        animalObject.setValue(animal.color, forKey: "color")
        animalObject.setValue(animal.weight, forKey: "weight")
        animalObject.setValue(animal.comments, forKey: "comments")
        
        
        print(animalObject)
        
        saveContext()
    }
    
    func fetchAnimals() -> [Animal]? {
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        do {
            let animalsData = try persistentContainer.viewContext.fetch(request)
            print(animalsData)
            let animals = animalsData.map { animalData in
                return Animal(
                    identifier: animalData.identifier,
                    name: animalData.name,
                    sexe: animalData.sexe,
                    species: Species(rawValue: animalData.species ?? ""),
                    breed: animalData.breed,
                    birthdate: animalData.birthdate,
                    weight: animalData.weight,
                    color: animalData.color,
                    comments: animalData.comments
                )
            }
            return animals
        } catch {
            print("Error fetching animals: \(error)")
            return nil
        }
    }
    
    func updateAnimal(animal: Animal) {
        print("In update CoreData")
        
        print(animal)
        //
        //        // Fetch the existing animal from Core Data based on its identifier
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        request.predicate = NSPredicate(format: "identifier == %@", animal.identifier ?? "")
        //
        do {
            let existingAnimals = try persistentContainer.viewContext.fetch(request)
            
            if let existingAnimal = existingAnimals.first {
                existingAnimal.name = animal.name
                existingAnimal.species = animal.species?.rawValue
                existingAnimal.breed = animal.breed
                existingAnimal.birthdate = animal.birthdate
                existingAnimal.weight = animal.weight
                existingAnimal.color = animal.color
                existingAnimal.comments = animal.comments
                
                // Save the context
                saveContext()
            }
        } catch {
            print("Error updating animal: \(error)")
        }
    }
    
    func deleteAnimal(animal: Animal) {
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        request.predicate = NSPredicate(format: "identifier == %@", animal.identifier ?? "")
        
        do {
            let fetchedAnimals = try persistentContainer.viewContext.fetch(request)
            
            for fetchedAnimal in fetchedAnimals {
                persistentContainer.viewContext.delete(fetchedAnimal)
            }
            
            saveContext()
        } catch {
            print("Error deleting animal: \(error)")
        }
    }
    
    //MARK: - Veterinarian Management
    
    func saveVeterinarian(veterinarian: Veterinarian) {
        
        
        guard !checkIfIdentifierExists(identifier: veterinarian.identifier, entityName: "VeterinarianSaved") else { return }
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "VeterinarianSaved", in: context)!
        
        let vetObject = NSManagedObject(entity: entity, insertInto: context)
        
        // Set properties of the Core Data entity using the values from the Animal object
        vetObject.setValue(UUID().uuidString, forKey: "identifier")
        vetObject.setValue(veterinarian.name, forKey: "name")
        vetObject.setValue(veterinarian.address, forKey: "address")
        vetObject.setValue(veterinarian.city, forKey: "city")
        vetObject.setValue(veterinarian.zipcode, forKey: "zipcode")
        vetObject.setValue(veterinarian.country, forKey: "country")
        vetObject.setValue(veterinarian.email, forKey: "email")
        vetObject.setValue(veterinarian.phone, forKey: "phone")
        vetObject.setValue(veterinarian.note, forKey: "note")

        // Save the record to the local storage
        saveContext()
    }
    
    func fetchVeterinarians() -> [Veterinarian]? {
        let request: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
        do {
            let veterinariansData = try persistentContainer.viewContext.fetch(request)
            print(veterinariansData)
            let veterinarians = veterinariansData.map { veterinarianData in
                return Veterinarian(
                    identifier: veterinarianData.identifier,
                    name: veterinarianData.name,
                    address: veterinarianData.address,
                    zipcode: veterinarianData.zipcode,
                    city: veterinarianData.city,
                    country: veterinarianData.country,
                    phone: veterinarianData.phone,
                    email: veterinarianData.email,
                    note: veterinarianData.note)
            }
            return veterinarians
        } catch {
            print("Error fetching Veterinarians : \(error)")
            return nil
        }
    }
    
    func updateVeterinarians(veterinarian: Veterinarian) {
        print("In update Vets CoreData")
        
        print(veterinarian)
        
        // Fetch the existing animal from Core Data based on its identifier
        let request: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
        request.predicate = NSPredicate(format: "identifier == %@", veterinarian.identifier ?? "")
        
        do {
            let existingVeterinarians = try persistentContainer.viewContext.fetch(request)
            
            if let existingVeterinarian = existingVeterinarians.first {
                existingVeterinarian.name = veterinarian.name
                existingVeterinarian.address = veterinarian.address
                existingVeterinarian.zipcode = veterinarian.zipcode
                existingVeterinarian.city = veterinarian.city
                existingVeterinarian.country = veterinarian.country
                existingVeterinarian.phone = veterinarian.phone
                existingVeterinarian.email = veterinarian.email
                existingVeterinarian.note = veterinarian.note
                
                // Save the context
                saveContext()
            }
        } catch {
            print("Error updating Vet: \(error)")
        }
    }
    
    func deleteVeterinarian(veterinarian: Veterinarian) {
        let request: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
        request.predicate = NSPredicate(format: "identifier == %@", veterinarian.identifier ?? "")
        
        do {
            let fetchedVeterinarians = try persistentContainer.viewContext.fetch(request)
            
            for fetchedVeterinarian in fetchedVeterinarians {
                persistentContainer.viewContext.delete(fetchedVeterinarian)
            }
            
            saveContext()
        } catch {
            print("Error deleting animal: \(error)")
        }
    }
    
    func checkIfIdentifierExists(identifier: String?, entityName: String) -> Bool {
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "identifier == %@", identifier ?? "")

        do {
            let fetchedEntities = try persistentContainer.viewContext.fetch(request)
            return fetchedEntities.count > 0
        } catch {
            print("Error checking if identifier exists: \(error)")
            return false
        }
    }
}
