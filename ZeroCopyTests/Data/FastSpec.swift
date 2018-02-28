//
//  FastSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class FastSpec: QuickSpec {
    
    override func spec() {
        
        var subject: Fast!
        var startDate: Date!
        var endDate: Date!
        var duration: Int!
        
        describe("FastSpec"){
            
            context("when fast is saved and retrieved") {
                
                beforeEach {
                    let coreDataHelpers = CoreDataHelpers()
                    let managedContext = coreDataHelpers.setUpInMemoryManagedObjectContext()
                    CoreDataManager.sharedInstance.managedContext = managedContext
                    
                    startDate = Date()
                    endDate = Date()
                    duration = Int(endDate.timeIntervalSince(startDate))
                    
                    CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
                    
                    guard let fasts = CoreDataManager.sharedInstance.retrieveFasts() else { return }
                    subject = fasts[0]
                }
                
                it("should have correct startdate, enddate and duration") {
                    expect(subject.startDate).to(equal(startDate))
                    expect(subject.endDate).to(equal(endDate))
                    expect(subject.duration).to(equal(duration))
                }
            }
        }
    }
}
