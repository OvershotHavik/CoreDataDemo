
//  ContentView.swift
//  CoreDataDemo
//
//  Created by Steve Plavetzky on 12/6/21.
//

import SwiftUI
import CoreData




struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
                  predicate: NSPredicate(format: "name == %@", "Shirt"),
                  animation: nil) var items: FetchedResults<Item>
    
    @FetchRequest(entity: Category.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
                  animation: nil) var categories: FetchedResults<Category>
    
    
    @State private var isActionSheetPresented = false
    @State private var isAlertPresented = false
    
    var body: some View {
        VStack{
            Button {
                //Hard code a category just to get the example to work, would typically bring up a text field or something to type it in
                let category = Category(context: managedObjectContext)
                category.name = "Clothes"
                PersistenceControllerStash.shared.save()
                print("added cateogiry")
            } label: {
                Text("Add Category")
            }

            Button {
                if categories.count == 0{
                    isAlertPresented.toggle()
                } else {
                    isActionSheetPresented.toggle()
                }
            } label: {
                Text("Add Item")
            }
            .actionSheet(isPresented: $isActionSheetPresented) {
                var buttons = [ActionSheet.Button]()
                categories.forEach { (category) in
                    print(category.name ?? "unknown")

                    let button = ActionSheet.Button.default(Text("\(category.name ?? "unknown")")) {
                        let item = Item(context: managedObjectContext)
                        //hard coded just to get the sample to work, typically would be a text field or something to fill it in
                        item.name = "Shirt"
                        item.toCategory = category
                        PersistenceControllerStash.shared.save()
                    }
                    buttons.append(button)
                }
                buttons.append(.cancel())
                return ActionSheet(title: Text("Please select a category"), message: nil, buttons: buttons)
            }
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text("Please add a category"),
                      message: nil,
                      dismissButton: .cancel(Text("Ok")))
            }
            List{
                ForEach(items, id: \.self) { item in
                    Text("\(item.name ?? "Unknown") - \(item.toCategory?.name ?? "Unknown")")
                }
                .onDelete(perform: removeItem)
            }
        }
    }
    func removeItem(at offsets: IndexSet){
        for index in offsets{
            let item = items[index]
            PersistenceControllerStash.shared.delete(item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
