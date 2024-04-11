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
        
        guard !checkIfIdentifierExists(identifier: animal.id, entityName: "AnimalSaved") else { return }
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "AnimalSaved", in: context)!
        
        let animalObject = NSManagedObject(entity: entity, insertInto: context) as! AnimalSaved
        
        animalObject.id = UUID().uuidString
        animalObject.identifier = animal.identifier
        animalObject.name = animal.name
        animalObject.sexe = animal.sexe ?? true
        animalObject.species = animal.species?.rawValue
        animalObject.breed = animal.breed
        animalObject.birthdate = animal.birthdate
        animalObject.color = animal.color
        animalObject.weight = animal.weight
        animalObject.comments = animal.comments
        
        saveContext()
    }
    
    func fetchAnimals() -> [Animal]? {
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        do {
            let animalsData = try persistentContainer.viewContext.fetch(request)
            let animals = animalsData.map { animalData in
                return Animal(
                    id: animalData.id,
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
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", animal.id ?? "")

        do {
            let existingAnimals = try persistentContainer.viewContext.fetch(request)
            
            if let existingAnimal = existingAnimals.first {
                existingAnimal.identifier = animal.identifier
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
        request.predicate = NSPredicate(format: "id == %@", animal.id ?? "")
        
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
        
        guard !checkIfIdentifierExists(identifier: veterinarian.id, entityName: "VeterinarianSaved") else { return }
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "VeterinarianSaved", in: context)!
        
        let vetObject = NSManagedObject(entity: entity, insertInto: context)
        
        // Set properties of the Core Data entity using the values from the Animal object
        vetObject.setValue(UUID().uuidString, forKey: "id")
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
            let veterinarians = veterinariansData.map { veterinarianData in
                return Veterinarian(
                    id: veterinarianData.id,
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
    
    func updateVeterinarian(veterinarian: Veterinarian) {
        
        // Fetch the existing animal from Core Data based on its identifier
        let request: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", veterinarian.id ?? "")
        
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
        request.predicate = NSPredicate(format: "id == %@", veterinarian.id ?? "")
        
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
    
    // MARK: Appointement Management

    func saveAppointement(appointement: Appointement) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "AppointementSaved", in: context)!
        let appointementObject = NSManagedObject(entity: entity, insertInto: context)
        
        // Set properties of the Core Data entity using the values from the Appointement object
        appointementObject.setValue(UUID().uuidString, forKey: "id")
        appointementObject.setValue(appointement.date, forKey: "date")
        appointementObject.setValue(appointement.descriptionRdv, forKey: "descriptionRdv")
        
        // Assuming that veterinarian and animals are relationships, handle them separately
        if let veterinarian = appointement.veterinarian {
            // Fetch the existing veterinarian from Core Data based on its identifier
            let fetchRequest: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", veterinarian.id ?? "")
            
            do {
                let results = try context.fetch(fetchRequest)
                if let existingVeterinarian = results.first {
                    appointementObject.setValue(existingVeterinarian, forKey: "veterinarian")
                }
            } catch {
                print("Error fetching veterinarian: \(error)")
            }
        }
        
        if let animals = appointement.animals {
            let animalSet = Set(animals.map { animal in
                let fetchRequest: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", animal.id ?? "")

                do {
                    let results = try context.fetch(fetchRequest)
                    if let existingAnimal = results.first {
                        return existingAnimal
                    }
                } catch {
                    print("Error fetching animal: \(error)")
                }
                
                // If the animal doesn't exist, create a new one (adjust this part based on your actual implementation)
                let newAnimal = AnimalSaved(context: context)
                newAnimal.id = animal.id
                // Set other properties as needed
                return newAnimal
            })
            
            appointementObject.setValue(animalSet, forKey: "animals")
        }
        
        saveContext()
    }

    func fetchAppointements() -> [Appointement]? {
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        do {
            let appointementsData = try persistentContainer.viewContext.fetch(request)

            let appointements = appointementsData.map { appointementData in
                var veterinarian: Veterinarian?
                if let veterinarianData = appointementData.veterinarian {
                    veterinarian = Veterinarian(
                        id: veterinarianData.id,
                        name: veterinarianData.name,
                        address: veterinarianData.address,
                        zipcode: veterinarianData.zipcode,
                        city: veterinarianData.city,
                        country: veterinarianData.country,
                        phone: veterinarianData.phone,
                        email: veterinarianData.email,
                        note: veterinarianData.note
                    )
                }

                var animals: [Animal]?
                if let animalDataSet = appointementData.animals,
                   let animalArray = Array(animalDataSet) as? [AnimalSaved] {
                    
                    animals = animalArray.map { animalData in
                        return Animal(
                            id: animalData.id ?? "",
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
                }
                
                return Appointement(
                    id: appointementData.id,
                    date: appointementData.date!,
                    descriptionRdv: appointementData.descriptionRdv,
                    animals: animals,
                    veterinarian: veterinarian
                )
            }
            return appointements
        } catch {
            return nil
        }
    }
    
    func fetchAppointementsSortedByDate() -> [Appointement]? {
        // Fetch appointments
        guard let appointements = fetchAppointements() else {
            return nil
        }
        
        // Sort appointments by date
        let sortedAppointements = appointements.sorted { $0.date! < $1.date! }
        
        return sortedAppointements
    }
    
    func fetchUpcomingAppointementsSortedByDate() -> [Appointement]? {
        // Fetch appointments
        guard let appointements = fetchAppointements() else {
            return nil
        }
        
        // Filter future appointments
        let now = Date()
        let upcomingAppointements = appointements.filter { $0.date ?? Date() >= now }
        
        // Sort appointments by date
        let sortedAppointements = upcomingAppointements.sorted { $0.date ?? Date() < $1.date ?? Date() }
        
        return sortedAppointements
    }

    func updateAppointement(appointement: Appointement) {        
        // Fetch the existing animal from Core Data based on its identifier
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", appointement.id ?? "")
        
        do {
            let existingAppointements = try persistentContainer.viewContext.fetch(request)
            
            if let existingAppointement = existingAppointements.first {
                existingAppointement.date = appointement.date
                existingAppointement.descriptionRdv = appointement.descriptionRdv
                
                // Save the context
                saveContext()
            }
        } catch {
            print("Error updating Appointement: \(error)")
        }
    }

    func deleteAppointement(appointement: Appointement) {
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", appointement.id ?? "")
        
        do {
            let fetchedAppointements = try persistentContainer.viewContext.fetch(request)
            
            for fetchedAppointement in fetchedAppointements {
                persistentContainer.viewContext.delete(fetchedAppointement)
            }
            
            saveContext()
        } catch {
            print("Error deleting Appointement: \(error)")
        }
    }

    // MARK: - Helper methods
    
    func checkIfIdentifierExists(identifier: String?, entityName: String) -> Bool {
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %@", identifier ?? "")
        
        do {
            let fetchedEntities = try persistentContainer.viewContext.fetch(request)
            return fetchedEntities.count > 0
        } catch {
            print("Error checking if identifier exists: \(error)")
            return false
        }
    }
}
