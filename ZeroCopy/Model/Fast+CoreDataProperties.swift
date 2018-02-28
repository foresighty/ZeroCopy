//
//  Fast+CoreDataProperties.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 13/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//
//

import Foundation
import CoreData


extension Fast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fast> {
        return NSFetchRequest<Fast>(entityName: "Fast")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var startDate: Date?
    
    public var duration: Int {
        var durationDouble : Double = 0
        if let startDate = startDate, let endDate = endDate {
            durationDouble = endDate.timeIntervalSince(startDate)
        }
        let duration: Int = Int(durationDouble)
        return duration
    }

}
