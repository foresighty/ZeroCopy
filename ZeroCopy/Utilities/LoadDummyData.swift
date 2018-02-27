//
//  LoadDummyData.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 26/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Foundation

class LoadDummyData {
    static let sharedInstance = LoadDummyData()
    private init(){}
    
    public func load() {
        let startDate = Date(timeIntervalSinceReferenceDate: 541291153)
        let endDate = Date(timeIntervalSinceReferenceDate: 541321153)
        CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
        CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
        CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
        CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
        CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
    }
}
