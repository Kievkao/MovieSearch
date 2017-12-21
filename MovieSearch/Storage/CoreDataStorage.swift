//
//  CoreDataStorage.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import CoreData

final class CoreDataStorage: Storage {
    private static let defaultSorting = Sorting.date(ascending: false)
    
    private var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IncidentAssist")
        
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error {
                print("CoreData setup error: \(error)")
            }
        })
        return container
    }()
    
    private func saveContext() -> Bool {
        guard viewContext.hasChanges else { return true }
        do {
            try viewContext.save()
            return true
        } catch let error {
            print("CoreData save error: \(error)")
            return false
        }
    }
}
