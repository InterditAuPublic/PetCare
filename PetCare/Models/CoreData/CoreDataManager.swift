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
        
    func saveAnimal(form: AnimalForm) {
        guard let identifier = form.identifier, !checkIfIdentifierExists(identifier: identifier, entityName: "AnimalSaved") else {
            NSLog("Failed to save animal: Identifier already exists or is invalid")
            return
        }
        
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "AnimalSaved", in: context) else { return }
        
        let animalObject = NSManagedObject(entity: entity, insertInto: context) as! AnimalSaved
        
        animalObject.id = form.id ?? UUID().uuidString
        animalObject.identifier = form.identifier
        animalObject.name = form.name
        animalObject.sexe = form.sexe
        animalObject.sterilized = form.sterilized
        animalObject.species = form.species.rawValue
        animalObject.breed = form.breed
        animalObject.birthdate = form.birthdate
        animalObject.color = form.color
        animalObject.comments = form.comments
        animalObject.image = form.image
        
        // Vérification et assignation de weight
        if let weight = form.weight {
            animalObject.weight = weight as Double
        } else {
            animalObject.weight = 0
        }
        
        do {
            try context.save()
        } catch {
            NSLog("Failed to save animal: \(error.localizedDescription)")
        }
    }


    func updateAnimal(form: AnimalForm) {
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", form.id ?? "")
        
        do {
            let existingAnimals = try persistentContainer.viewContext.fetch(request)
            
            guard let existingAnimal = existingAnimals.first else {
                print("Failed to update animal: Animal not found")
                return
            }
            
            existingAnimal.identifier = form.identifier
            existingAnimal.name = form.name
            existingAnimal.sexe = form.sexe
            existingAnimal.sterilized = form.sterilized
            existingAnimal.species = form.species.rawValue
            existingAnimal.breed = form.breed
            existingAnimal.birthdate = form.birthdate
            existingAnimal.weight = form.weight as Double? ?? 1.0
            existingAnimal.color = form.color
            existingAnimal.comments = form.comments
            existingAnimal.image = form.image
            
            saveContext()
        } catch {
            print("Error updating animal: \(error)")
        }
    }

    func deleteAnimal(animal: Animal) {
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", animal.id)
        
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

    func fetchAnimal(byId id: String) -> Animal? {
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            if let animalSaved = try persistentContainer.viewContext.fetch(request).first {
                return Animal(
                    id: animalSaved.id!, // Unwrap safely
                    identifier: animalSaved.identifier,
                    name: animalSaved.name!,
                    sexe: animalSaved.sexe,
                    sterilized: animalSaved.sterilized,
                    species: Species(rawValue: animalSaved.species!)!,
                    breed: animalSaved.breed,
                    birthdate: animalSaved.birthdate,
                    weight: animalSaved.weight as Double,
                    color: animalSaved.color,
                    comments: animalSaved.comments,
                    image: animalSaved.image
                )
            }
        } catch {
            print("Error fetching animal: \(error)")
        }
        return nil
    }

    func fetchAnimals() -> [Animal]? {
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        do {
            let animalsData = try persistentContainer.viewContext.fetch(request)
            let animals = animalsData.map { animalData in
                return Animal(
                    id: animalData.id!, // Unwrap safely
                    identifier: animalData.identifier,
                    name: animalData.name!,
                    sexe: animalData.sexe,
                    sterilized: animalData.sterilized,
                    species: Species(rawValue: animalData.species ?? "")!,
                    breed: animalData.breed,
                    birthdate: animalData.birthdate,
                    weight: animalData.weight as Double?,
                    color: animalData.color,
                    comments: animalData.comments,
                    image: animalData.image
                )
            }
            return animals
        } catch {
            print("Error fetching animals: \(error)")
            return nil
        }
    }
    
    // MARK: - Veterinarian Management

    func saveVeterinarian(form: VeterinarianForm) {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "VeterinarianSaved", in: context) else { return }
        
        let veterinarianObject = NSManagedObject(entity: entity, insertInto: context) as! VeterinarianSaved
        veterinarianObject.id = UUID().uuidString
        veterinarianObject.name = form.name
        veterinarianObject.address = form.address
        veterinarianObject.zipcode = form.zipcode
        veterinarianObject.city = form.city
        veterinarianObject.phone = form.phone
        veterinarianObject.email = form.email
        veterinarianObject.note = form.note
        
        saveContext()
    }

    func updateVeterinarian(form: VeterinarianForm) {
        let request: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", form.id ?? "")
        
        do {
            let existingVeterinarians = try persistentContainer.viewContext.fetch(request)
            
            guard let existingVet = existingVeterinarians.first else {
                print("Failed to update veterinarian: Veterinarian not found")
                return
            }
            
            existingVet.name = form.name
            existingVet.address = form.address
            existingVet.zipcode = form.zipcode
            existingVet.city = form.city
            existingVet.phone = form.phone
            existingVet.email = form.email
            existingVet.note = form.note
            
            saveContext()
        } catch {
            print("Error updating veterinarian: \(error)")
        }
    }

    func deleteVeterinarian(veterinarian: Veterinarian) {
        let request: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", veterinarian.id)
        
        do {
            let fetchedVeterinarians = try persistentContainer.viewContext.fetch(request)
            
            for fetchedVeterinarian in fetchedVeterinarians {
                persistentContainer.viewContext.delete(fetchedVeterinarian)
            }
            
            saveContext()
        } catch {
            print("Error deleting veterinarian: \(error)")
        }
    }

    func fetchVeterinarian(byId id: String) -> VeterinarianSaved? {
        let request: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            return try persistentContainer.viewContext.fetch(request).first

        } catch {
            print("Error fetching veterinarian: \(error)")
        }
        return nil
    }

    func fetchVeterinarians() -> [Veterinarian]? {
        let request: NSFetchRequest<VeterinarianSaved> = VeterinarianSaved.fetchRequest()
        do {
            let veterinariansData = try persistentContainer.viewContext.fetch(request)
            let veterinarians = veterinariansData.map { veterinarianData in
                return Veterinarian(
                    id: veterinarianData.id!,
                    name: veterinarianData.name!,
                    address: veterinarianData.address,
                    zipcode: veterinarianData.zipcode,
                    city: veterinarianData.city,
                    phone: veterinarianData.phone,
                    email: veterinarianData.email,
                    note: veterinarianData.note,
                    appointements: fetchAppointments()?.filter { $0.veterinarian.id == veterinarianData.id } ?? []
                )
            }
            return veterinarians
        } catch {
            print("Error fetching veterinarians: \(error)")
            return nil
        }
    }

    
    // MARK: - Appointment Management
        
    func saveAppointment(form: AppointmentForm) {
        let context = persistentContainer.viewContext
        let appointment = AppointementSaved(context: context)
        appointment.id = UUID().uuidString
        appointment.date = form.date
        appointment.descriptionRdv = form.descriptionRdv
        
        if let veterinarian = fetchVeterinarian(byId: form.veterinarian.id) {
            appointment.veterinarian = veterinarian
        } else {
            print("Error: Veterinarian not found")
            return
        }
        
        var animalsSet = Set<AnimalSaved>()
        for animal in form.animals {
            if let animalSaved = fetchAnimalSaved(byId: animal.id) {
                animalsSet.insert(animalSaved)
            } else {
                print("Error: Animal with id \(animal.id) not found")
            }
        }
        appointment.animals = animalsSet as NSSet
        
        saveContext()
    }

    func fetchAnimalSaved(byId id: String) -> AnimalSaved? {
        let request: NSFetchRequest<AnimalSaved> = AnimalSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            return try persistentContainer.viewContext.fetch(request).first
        } catch {
            print("Error fetching animal: \(error)")
            return nil
        }
    }

    func fetchAppointments() -> [Appointment]? {
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        do {
            let appointmentsData = try persistentContainer.viewContext.fetch(request)
            let appointments = appointmentsData.map { appointmentData in
                let veterinarian: Veterinarian? = {
                    if let veterinarianData = appointmentData.veterinarian {
                        return Veterinarian(
                            id: veterinarianData.id!,
                            name: veterinarianData.name,
                            address: veterinarianData.address,
                            zipcode: veterinarianData.zipcode,
                            city: veterinarianData.city,
                            phone: veterinarianData.phone,
                            email: veterinarianData.email,
                            note: veterinarianData.note
                        )
                    }
                    return nil
                }()
                
                let animals: [Animal] = {
                    if let animalDataSet = appointmentData.animals as? Set<AnimalSaved> {
                        return animalDataSet.map { animalData in
                            return Animal(
                                id: animalData.id ?? "",
                                identifier: animalData.identifier,
                                name: animalData.name!,
                                sexe: animalData.sexe,
                                sterilized: animalData.sterilized,
                                species: Species(rawValue: animalData.species ?? ""),
                                breed: animalData.breed,
                                birthdate: animalData.birthdate,
                                weight: animalData.weight as Double?,
                                color: animalData.color,
                                comments: animalData.comments
                            )
                        }
                    }
                    return []
                }()
                
                return Appointment(
                    id: appointmentData.id!,
                    date: appointmentData.date!,
                    descriptionRdv: appointmentData.descriptionRdv,
                    animals: animals,
                    veterinarian: veterinarian
                )
            }
            return appointments
        } catch {
            print("Error fetching appointments: \(error)")
            return nil
        }
    }

    func fetchAppointmentsSortedByDate() -> [Appointment]? {
        guard let appointments = fetchAppointments() else {
            return nil
        }
        
        let sortedAppointments = appointments.sorted { $0.date < $1.date }
        
        return sortedAppointments
    }

    func fetchUpcomingAppointmentsSortedByDate() -> [Appointment]? {
        guard let appointments = fetchAppointments() else {
            return nil
        }
        
        let now = Date()
        let upcomingAppointments = appointments.filter { $0.date >= now }
        
        let sortedAppointments = upcomingAppointments.sorted { $0.date < $1.date }
        
        return sortedAppointments
    }
    
    func fetchPastAppointmentsSortedByDate() -> [Appointment]? {
        guard let appointments = fetchAppointments() else {
            return nil
        }
        
        let now = Date()
        let pastAppointments = appointments.filter { $0.date < now }
        
        let sortedAppointments = pastAppointments.sorted { $0.date < $1.date }
        
        return sortedAppointments
    }

    func updateAppointment(appointment: AppointmentForm) {
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", appointment.id ?? "")

        do {
            let existingAppointments = try persistentContainer.viewContext.fetch(request)
            
            if let existingAppointment = existingAppointments.first {
                existingAppointment.date = appointment.date
                existingAppointment.descriptionRdv = appointment.descriptionRdv
                
                if let veterinarian = fetchVeterinarian(byId: appointment.veterinarian.id) {
                    existingAppointment.veterinarian = veterinarian // Corrected assignment
                } else {
                    print("Error: Veterinarian not found")
                    return
                }
                
                var animalsSet = Set<AnimalSaved>()
                for animal in appointment.animals {
                    if let animalSaved = fetchAnimalSaved(byId: animal.id) {
                        animalsSet.insert(animalSaved)
                    } else {
                        print("Error: Animal with id \(animal.id) not found")
                    }
                }
                existingAppointment.animals = animalsSet as NSSet
                
                saveContext()
            } else {
                print("Error: Appointment not found")
            }
        } catch {
            print("Error updating appointment: \(error)")
        }
    }

    func deleteAppointment(appointment: Appointment) {
        let request: NSFetchRequest<AppointementSaved> = AppointementSaved.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", appointment.id)
        
        do {
            let fetchedAppointments = try persistentContainer.viewContext.fetch(request)
            
            for fetchedAppointment in fetchedAppointments {
                persistentContainer.viewContext.delete(fetchedAppointment)
            }
            
            saveContext()
        } catch {
            print("Error deleting appointment: \(error)")
        }
    }

    
    // MARK: - Helper methods
    
    func checkIfIdentifierExists(identifier: String?, entityName: String) -> Bool {
        guard let identifier = identifier else { return false }
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %@", identifier)
        
        do {
            let fetchedEntities = try persistentContainer.viewContext.fetch(request)
            return fetchedEntities.count > 0
        } catch {
            print("Error checking if identifier exists: \(error)")
            return false
        }
    }
}
