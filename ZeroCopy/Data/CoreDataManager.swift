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

    private init() { }

    func recordFast(startDate: Date, endDate: Date, duration: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fastEntity = NSEntityDescription.entity(forEntityName: "Fast", in: managedContext)
        let fast = NSManagedObject(entity: fastEntity!, insertInto: managedContext)
        
        var fastToSave = FastDataModel()
        fastToSave.startDate = startDate
        fastToSave.endDate = endDate
        
        fast.setValue(fastToSave.startDate, forKey: "startTime")
        fast.setValue(fastToSave.endDate, forKey: "endTime")
        fast.setValue(fastToSave.duration, forKey: "duration")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        print("Saved Fast = \(fast)")

    }
    
    func retrieveFasts() -> [Fast]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Fast")
        fetchRequest.fetchLimit = 7
        let sort = NSSortDescriptor(key: #keyPath(Fast.startTime), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.returnsObjectsAsFaults = false
        let listOfFasts : [Fast] = try! managedContext.fetch(fetchRequest) as! [Fast]

        return listOfFasts
    
    }
}
