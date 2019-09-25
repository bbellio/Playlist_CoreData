//
//  CoreDataStack.swift
//  Playlist_CoreData
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let container: NSPersistentContainer = {
        // same name as xcdata model file
        let container = NSPersistentContainer(name: "Playlist_CoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent store \(error)")
            }
        })
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
