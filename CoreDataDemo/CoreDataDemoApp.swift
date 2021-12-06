//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by Steve Plavetzky on 12/6/21.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    
    //Stash Example
//    let persistenceControllerStash = PersistenceControllerStash.shared
    
    //todo example
    let persistenceControllerToDo = PersistenceControllerToDo.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ToDoView()
                .environment(\.managedObjectContext, persistenceControllerToDo.container.viewContext)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceControllerStash.container.viewContext)
        }
        /*
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase{
            case .background:
                print("scene is in the background")
//                persistenceController.save()
            case .inactive:
                print("scene is inactive")
            case .active:
                print("scene is active")
            @unknown default:
                print("Apple must have changed something")
            }
        }
         */
    }
}
