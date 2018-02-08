//
//  CoreDataHelpers.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 08/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import CoreData

class CoreDataHelpers {
    // This function is to create a mock Managed Object Context
    // and creates in-memory persistent store for testing CoreData
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        
        // creates a managed object model aka schema / blueprint
        // from all merging all managed object models
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        // create a new persistent store coordinator for the managed object model
        // persistent store coordinator builds and retrieves the stuff
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        // try to create a new in memory persistent store
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        // creates a managed object context, i.e. a drawing board
        // for writing up object retrieval plans
        let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        // assign the managed object context to the builder
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
}
