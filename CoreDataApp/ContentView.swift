//
//  ContentView.swift
//  CoreDataApp
//
//  Created by Wedad Almehmadi on 26/12/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @FetchRequest(entity: NamesEntity.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \NamesEntity.pepoleName, ascending: false)])
    var Names: FetchedResults<NamesEntity>
    
    @State var textFieldText: String = ""
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                TextField("Enter Name...", text: $textFieldText)
                    .padding(.top, 40)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth:250)
                    .frame(maxHeight: 50)
                Button {
                    addItem()
                } label: {
                    Text("Submit")
                        .foregroundColor (.white)
                        .frame(maxWidth:100)
                        .frame(height: 40)
                        .background(Color(.gray))
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                List {
                    ForEach(Names) { name in
                        Text(name.pepoleName ?? "")
                    }.onDelete (perform: deleteItems)
                }
                
            }.background(Color(red: 0.949, green: 0.949, blue: 0.971))
            .navigationTitle("Names System")
            
        }
    }
    
    private func addItem() {
        withAnimation {
            let newName = NamesEntity(context: viewContext)
            newName.pepoleName = textFieldText
            saveItems()
            textFieldText = ""
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let NamesEntity = Names [index]
            viewContext.delete(NamesEntity)
            saveItems()
        }
    }
    private func saveItems () {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
