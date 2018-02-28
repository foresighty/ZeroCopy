//
//  CoreDataManager.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 30/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    static let sharedInstance = CoreDataManager()

    private let appDelegate: AppDelegate?
    public var managedContext: NSManagedObjectContext!
    
    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
    }
    
    func recordFast(startDate: Date, endDate: Date) {
        let fastEntity = NSEntityDescription.entity(forEntityName: "Fast", in: managedContext)
        let fast = NSManagedObject(entity: fastEntity!, insertInto: managedContext)
        
        fast.setValue(startDate, forKey: "startDate")
        fast.setValue(endDate, forKey: "endDate")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateFast(fast: Fast) {        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveFasts() -> [Fast]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Fast")
        fetchRequest.fetchLimit = 7
        let sort = NSSortDescriptor(key: #keyPath(Fast.startDate), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.returnsObjectsAsFaults = false
        if let listOfFasts : [Fast] = try? managedContext.fetch(fetchRequest) as! [Fast] {
            return listOfFasts
        }
        return [Fast]()
    }
    
    func deleteFasts(fast: Fast) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Fast")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "startDate = %@", fast.startDate! as NSDate)
        
        if let listOfFasts : [Fast] = try? managedContext.fetch(fetchRequest) as! [Fast] {
            managedContext.delete(listOfFasts[0])
        }
    }
    
    func deleteAllFasts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Fast")
        
        if let listOfFasts : [Fast] = try? managedContext.fetch(fetchRequest) as! [Fast] {
            for fast in listOfFasts {
                managedContext.delete(fast)
            }
        }
    }

}
