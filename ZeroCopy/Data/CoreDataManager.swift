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
        
        fast.setValue(startDate, forKey: "startTime")
        fast.setValue(endDate, forKey: "endTime")
        fast.setValue(duration, forKey: "duration")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    func retrieveFast(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fastFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Fast")
        fastFetch.fetchLimit = 10
        fastFetch.returnsObjectsAsFaults = false
        let fastsFetched = try! managedContext.fetch(fastFetch)
        print("Full array of fasts: ")
        print(fastsFetched)
    
        let result = fastsFetched[fastsFetched.count-1] as! Fast
        print("Last Fast")
        print(result)
    }
}
