//
//  CoreDataManagerSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 08/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class CoreDataManagerSpec: QuickSpec {
    override func spec() {
        
        let subject = CoreDataManager.sharedInstance
        
        describe("CoreDataManager"){
            
            context("when system records a fast") {
                
                beforeEach {
                    let startDate = Date(timeIntervalSince1970: 1518078663)
                    let endDate = Date(timeIntervalSince1970: 1518078700)
                    var fast = FastDataModel()
                    fast.startDate = startDate
                    fast.endDate = endDate
                    subject.recordFast(startDate: startDate, endDate: endDate)
                }
                
                it("should save a fast in CoreData"){
                    
                }
            }
        }
    }
}

