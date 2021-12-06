//
//  PersistenceControllerToDo.swift
//  CoreDataDemo
//
//  Created by Steve Plavetzky on 12/6/21.
//

import CoreData

struct PersistenceControllerToDo{
    static let shared = PersistenceControllerToDo()
    
    let container: NSPersistentContainer
    
    init() {
//        container = NSPersistentContainer(name: "ToDo") // local core data 
        container = NSPersistentCloudKitContainer(name: "ToDo") // cloud kit
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error loading core data: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
