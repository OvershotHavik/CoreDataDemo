//
//  ToDoView.swift
//  CoreDataDemo
//
//  Created by Steve Plavetzky on 12/6/21.
//

import SwiftUI

struct ToDoView: View {
    @Environment (\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)])
    
    
    private var tasks : FetchedResults<Task>
    var body: some View {
        NavigationView{
            List {
                ForEach(tasks) { task in
                    Text(task.title ?? "untitled")
                        .onTapGesture (count: 1, perform: {
                            updateTask(task)
                        })
                }
                .onDelete(perform: deleteTask)

            }
            .navigationTitle("Todo List 📝")
            .navigationBarItems(trailing: Button("Add Task"){
                addTask()
            })
        }
        
    }
    private func deleteTask(offsets: IndexSet){
        withAnimation {
            offsets.map{ tasks[$0]}.forEach(viewContext.delete)
            saveContext()
        }
    }
                                       
    private func updateTask(_ task: FetchedResults<Task>.Element){
        withAnimation {
            task.title = "Updated"
            saveContext()
        }
    }
    

                                       
                                       
                                       
    private func saveContext() {
        do {
            try viewContext.save()
        } catch let e {
            print("Error saving: \(e.localizedDescription)")
        }
    }
    private func addTask(){
        withAnimation {
            let newTask = Task(context: viewContext)
            newTask.title = "New Task \(Date())"
            newTask.date = Date()
            

            saveContext()
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
    }
}
