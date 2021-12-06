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
        container = NSPersistentContainer(name: "ToDo")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error loading core data: \(error.localizedDescription)")
            }
        }
    }
}
