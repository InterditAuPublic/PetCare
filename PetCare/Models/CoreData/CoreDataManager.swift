//
//  CoreDataManager.swift
//  PetCare
//
//  Created by Melvin Poutrel on 09/01/2024.
//
import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(coreDataStack: CoreDataStack.shared)
    
    private let coreDataStack: CoreDataStack

    // Initializer to inject CoreDataStack
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Core Data stack
    
    private var persistentContainer: NSPersistentContainer {
        return coreDataStack.persistentContainer
    }
    
    private func saveContext() {
        coreDataStack.saveContext()
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
        animalObject.weight = animal.weight ?? 1.0
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
                existingAnimal.weight = animal.weight ?? 1.0
                existingAnimal.color = animal.color
                existingAnimal.comments = animal.comments
                
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
    
    // MARK: - Veterinarian Management
    
    func saveVeterinarian(veterinarian: Veterinarian) {
        guard !checkIfIdentifierExists(identifier: veterinarian.id, entityName: "VeterinarianSaved") else { return }
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "VeterinarianSaved", in: context)!
        
        let vetObject = NSManagedObject(entity: entity, insertInto: context)
        
        vetObject.setValue(UUID().uuidString, forKey: "id")
        vetObject.setValue(veterinarian.name, forKey: "name")
        vetObject.setValue(veterinarian.address, forKey: "address")
        vetObject.setValue(veterinarian.city, forKey: "city")
        vetObject.setValue(veterinarian.zipcode, forKey: "zipcode")
        vetObject.setValue(veterinarian.country, forKey: "country")
        vetObject.setValue(veterinarian.email, forKey: "email")
        vetObject.setValue(veterinarian.phone, forKey: "phone")
        vetObject.setValue(veterinarian.note, forKey: "note")
        
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
            print("Error fetching Veterinarians: \(error)")
            return nil
        }
    }
    
    func updateVeterinarian(veterinarian: Veterinarian) {
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
    
    // MARK: - Appointment Management

    func saveAppointement(appointment: Appointement) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "AppointementSaved", in: context)!
        let appointmentObject = NSManagedObject(entity: entity, insertInto: context)
        
        appointmentObject.setValue(UUID().uuidString, forKey: "id")
        appointmentObject.setValue(appointment.date, forKey: "date")
        appointmentObject.setValue(appointment.descriptionRdv, forKey: "descriptionRdv")

        if let veterinarian = appointment.veterinarian {
            let fetchRequest: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", veterinarian.id ?? "")
            
            do {
                let results = try context.fetch(fetchRequest)
                if let existingVeterinarian = results.first {
                    appointmentObject.setValue(existingVeterinarian, forKey: "veterinarian")
                }
            } catch {
                print("Error fetching veterinarian: \(error)")
            }
        }
        
        if let animals = appointment.animals {
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
                
                let newAnimal = AnimalSaved(context: context)
                newAnimal.id = animal.id
                return newAnimal
            })
            
            appointmentObject.setValue(animalSet, forKey: "animals")
        }
        
        saveContext()
    }

    func fetchAppointements() -> [Appointement]? {
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        do {
            let appointmentsData = try persistentContainer.viewContext.fetch(request)

            let appointments = appointmentsData.map { appointmentData in
                var veterinarian: Veterinarian?
                if let veterinarianData = appointmentData.veterinarian {
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
                if let animalDataSet = appointmentData.animals,
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
                    id: appointmentData.id,
                    date: appointmentData.date!,
                    descriptionRdv: appointmentData.descriptionRdv,
                    animals: animals,
                    veterinarian: veterinarian
                )
            }
            return appointments
        } catch {
            return nil
        }
    }
    
    func fetchAppointementsSortedByDate() -> [Appointement]? {
        guard let appointments = fetchAppointements() else {
            return nil
        }
        
        let sortedAppointments = appointments.sorted { $0.date! < $1.date! }
        
        return sortedAppointments
    }
    
    func fetchUpcomingAppointementsSortedByDate() -> [Appointement]? {
        guard let appointments = fetchAppointements() else {
            return nil
        }
        
        let now = Date()
        let upcomingAppointments = appointments.filter { $0.date ?? Date() >= now }
        
        let sortedAppointments = upcomingAppointments.sorted { $0.date ?? Date() < $1.date ?? Date() }
        
        return sortedAppointments
    }

    func updateAppointement(appointment: Appointement) {
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", appointment.id ?? "")
        
        do {
            let existingAppointments = try persistentContainer.viewContext.fetch(request)
            
            if let existingAppointment = existingAppointments.first {
                existingAppointment.date = appointment.date
                existingAppointment.descriptionRdv = appointment.descriptionRdv
                
                saveContext()
            }
        } catch {
            print("Error updating Appointment: \(error)")
        }
    }

    func deleteAppointment(appointment: Appointement) {
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", appointment.id ?? "")
        
        do {
            let fetchedAppointments = try persistentContainer.viewContext.fetch(request)
            
            for fetchedAppointment in fetchedAppointments {
                persistentContainer.viewContext.delete(fetchedAppointment)
            }
            
            saveContext()
        } catch {
            print("Error deleting Appointment: \(error)")
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
