//
//  CoreDataStorage.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import CoreData

final class CoreDataStorage {
    private var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieSearch")
        
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

extension CoreDataStorage: Storage {
    func save(search: String, keepCapacity: Int, completion: ((Bool) -> Void)?) {
        guard let results = getManagedLatestSearches(sorting: Sorting.date(ascending: false)) else {
            completion?(false)
            return
        }
        
        let newSearch: ManagedSearch
        let existed = results.first(where: { $0.query?.lowercased() == search.lowercased() })
        
        if keepCapacity > 0, results.count >= keepCapacity {
            newSearch = existed ?? results[keepCapacity - 1]
            
            if results.count > keepCapacity {
                results[keepCapacity...results.count - 1].forEach { viewContext.delete($0) }
            }
        } else {
            newSearch = existed ?? ManagedSearch(context: viewContext)
        }
        
        newSearch.query = search
        newSearch.usageDate = Date()
        
        let success = saveContext()
        completion?(success)
    }
    
    func getLastSearches(sorting: Sorting, completion: (([Search]) -> Void)) {
        if let results = getManagedLatestSearches(sorting: sorting) {
            completion(results.flatMap { $0.plain() })
        } else {
            completion([])
        }
    }
    
    private func getManagedLatestSearches(sorting: Sorting) -> [ManagedSearch]? {
        let fetchRequest: NSFetchRequest<ManagedSearch> = ManagedSearch.fetchRequest()
        fetchRequest.sortDescriptors = [ManagedSearch.sortDescriptor(forType: sorting)]
        return try? persistentContainer.viewContext.fetch(fetchRequest)
    }
}
