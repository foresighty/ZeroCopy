//
//  CoreDataManagerSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 14/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class CoreDataManagerSpec: QuickSpec {
    
    override func spec() {

        describe("CoreDataManagerSpec") {
            
            beforeEach {
                let coreDataHelpers = CoreDataHelpers()
                let managedContext = coreDataHelpers.setUpInMemoryManagedObjectContext()
                CoreDataManager.sharedInstance.managedContext = managedContext
            }

            context("when recording a fast") {
                
                var startDate: Date!
                var endDate: Date!
                var fasts: [Fast]!
                
                beforeEach {
                    startDate = Date(timeIntervalSince1970: 100000)
                    endDate = Date(timeIntervalSince1970: 200000)
                    CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
                    fasts = CoreDataManager.sharedInstance.retrieveFasts()
                }
                
                it("fasts stored in Core Data should not be nil") {
                    expect(fasts[0].startDate).toNot(beNil())
                }
                
                it("should store correct fast in Core Data"){
                    expect(fasts[0].startDate).to(equal(startDate))
                    expect(fasts[0].endDate).to(equal(endDate))
                }
            }
            
            context("when updating a fast"){
                var startDate: Date!
                var endDate: Date!
                var newStartDate: Date!
                var newEndDate: Date!
                var initialFast: [Fast]!
                var afterUpdateFasts: [Fast]!
                
                beforeEach {
                    startDate = Date(timeIntervalSince1970: 100000)
                    endDate = Date(timeIntervalSince1970: 200000)
                    CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
                    initialFast = CoreDataManager.sharedInstance.retrieveFasts()
                    let newFast = initialFast[0]
                    newStartDate = Date(timeIntervalSince1970: 400000)
                    newEndDate = Date(timeIntervalSince1970: 500000)
                    newFast.startDate = newStartDate
                    newFast.endDate = newEndDate
                    CoreDataManager.sharedInstance.updateFast(fast: newFast)
                    afterUpdateFasts = CoreDataManager.sharedInstance.retrieveFasts()
                }
                
                it("should not save a new fast"){
                    expect(afterUpdateFasts.count).to(equal(1))
                }
                
                it("should update the same fast object"){
                    expect(afterUpdateFasts[0]).to(be(initialFast[0]))
                }
                
                it("should not have the same details as the old version"){
                    expect(afterUpdateFasts[0].startDate).toNot(equal(startDate))
                    expect(afterUpdateFasts[0].endDate).toNot(equal(endDate))
                }
                
                it("should update existing fast with new dates"){
                    expect(afterUpdateFasts[0].startDate).to(equal(newStartDate))
                    expect(afterUpdateFasts[0].endDate).to(equal(newEndDate))
                }
            }
            
            context("when retrieving fasts"){
                var fasts: [Fast]!
                
                beforeEach {
                    CoreDataManager.sharedInstance.recordFast(startDate: Date(), endDate: Date())
                    CoreDataManager.sharedInstance.recordFast(startDate: Date(), endDate: Date())
                    CoreDataManager.sharedInstance.recordFast(startDate: Date(), endDate: Date())
                    
                    fasts = CoreDataManager.sharedInstance.retrieveFasts()
                }
                
                it("should return the correct number of fasts") {
                    expect(fasts.count).to(equal(3))
                }
                
            }
            
            context("when retrieving fasts where no fasts available") {
                var fasts: [Fast]!

                beforeEach {
                    fasts = CoreDataManager.sharedInstance.retrieveFasts()
                }
                
                it("should return an empty fast") {
                    expect(fasts).to(beEmpty())
                }
            }
            
            context("when deleting a fast") {
                var fasts: [Fast]!
                var startDate: Date!
                var endDate: Date!
                var fastToDelete: Fast!
                
                beforeEach {
                    startDate = Date(timeIntervalSince1970: 10000)
                    endDate = Date(timeIntervalSince1970: 20000)
                    CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
                    fasts = CoreDataManager.sharedInstance.retrieveFasts()
                    fastToDelete = fasts[0]
                    CoreDataManager.sharedInstance.deleteFasts(fast: fastToDelete)
                }
                
                it("should delete a fast to CoreData") {
                    expect(CoreDataManager.sharedInstance.retrieveFasts()).to(beEmpty())
                }
                
            }
            
            context("when deleting all fasts") {                
                beforeEach {
                    CoreDataManager.sharedInstance.recordFast(startDate: Date(), endDate: Date())
                    CoreDataManager.sharedInstance.recordFast(startDate: Date(), endDate: Date())
                    CoreDataManager.sharedInstance.recordFast(startDate: Date(), endDate: Date())
                    
                    CoreDataManager.sharedInstance.deleteAllFasts()
                }
                
                it("should delete all fasts from CoreData") {
                    expect(CoreDataManager.sharedInstance.retrieveFasts()).to(beEmpty())
                }
            }
            
        }
    }
}
