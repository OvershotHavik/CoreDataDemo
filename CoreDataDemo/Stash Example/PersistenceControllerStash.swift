//
//  Persistence.swift
//  CoreDataDemo
//
//  Created by Steve Plavetzky on 12/6/21.
//

import CoreData

struct PersistenceControllerStash {
    static let shared = PersistenceControllerStash()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Stash")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error loading core data: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = { _ in }) {
        let context = container.viewContext
        if context.hasChanges{
            do {
                try context.save()
                completion(nil)
            }catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = { _ in }) {
        let context = container.viewContext
        
        context.delete(object)
        save(completion: completion)
    }
}



