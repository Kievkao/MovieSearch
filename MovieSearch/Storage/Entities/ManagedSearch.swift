//
//  ManagedSearch.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import CoreData

class ManagedSearch: NSManagedObject {
    static let queryKey = "query"
    fileprivate static let usageDateKey = "usageDate"
    
    static func sortDescriptor(forType type: Sorting) -> NSSortDescriptor {
        switch type {
        case .alphabetical(let ascending):
            return NSSortDescriptor(key: queryKey, ascending: ascending)
            
        case .date(let ascending):
            return NSSortDescriptor(key: usageDateKey, ascending: ascending)
        }
    }
    
    func plain() -> Search? {
        guard let query = query else { return nil }
        return Search(query: query)
    }
}
