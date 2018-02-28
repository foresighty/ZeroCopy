//
//  SaveFastViewControllerSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class SaveFastViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("SaveFastViewController") {
            
            var subject: SaveFastViewController!
            var startDate: Date!
            var endDate: Date!
            var interval: Int!
            
            context("when creating the view controller for a new fast") {
                
                beforeEach {
                    startDate = Date()
                    endDate = Date()
                    subject = SaveFastViewController(startDate: startDate, endDate: endDate)
                    interval = Int(endDate.timeIntervalSince(startDate))
                    subject.viewDidLoad()
                }
                
                it("should create and configure the view controller correctly") {
                    expect(subject).toNot(beNil())
                    expect(subject.startDate).to(equal(startDate))
                    expect(subject.endDate).to(equal(endDate))
                    expect(subject.duration).to(equal(interval))
                    expect(subject.tableView.dataSource).to(be(subject))
                    expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(3))
                }
                
                context("when the view loads") {
                    beforeEach {
                        subject.viewDidLoad()
                    }
                    it("should configure necessary views") {
                        expect(subject.dateFormatter.dateFormat).to(equal("h:mmpo"))
                        expect(subject.tableView).toNot(beNil())
                        expect(subject.tableView.dataSource).to(be(subject))
                        expect(subject.view.backgroundColor).to(equal(UIColor.white))
                        expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(3))
                    }
                }
                
                context("when cancel pressed") {
                    var mockNavigationController: MockNavigationController!
                    
                    beforeEach {
                        mockNavigationController = MockNavigationController(rootViewController: UIViewController())
                        mockNavigationController.pushViewController(subject, animated: false)
                        subject.cancelPressed()
                    }
                    
                    it("should pop the save fast view controller") {
                        expect(mockNavigationController.poppedViewController).to(beTrue())
                    }
                }
            }
            
            context("when creating the view controller for existing fast") {
               
                var listOfFasts: [Fast]!
                var fast: Fast!
                
                beforeEach {
                    startDate = Date()
                    endDate = Date()
                    
                    let coreDataHelpers = CoreDataHelpers()
                    let managedContext = coreDataHelpers.setUpInMemoryManagedObjectContext()
                    CoreDataManager.sharedInstance.managedContext = managedContext
                    CoreDataManager.sharedInstance.recordFast(startDate: startDate, endDate: endDate)
                    
                    listOfFasts = CoreDataManager.sharedInstance.retrieveFasts()
                    
                    fast = listOfFasts[0]
                    
                    subject = SaveFastViewController(with: fast)
                    interval = Int(endDate.timeIntervalSince(startDate))
                    subject.viewDidLoad()
                }
                
                it("should create and configure the view controller correctly") {
                    expect(subject).toNot(beNil())
                    expect(subject.startDate).to(equal(startDate))
                    expect(subject.endDate).to(equal(endDate))
                    expect(subject.duration).to(equal(interval))
                }
                
                context("when selecting edit button for start date") {
                    beforeEach {
                        subject.datePickerForStartDate()
                    }
                    it("datepicker should have a date as start date") {
                        expect(("\(subject.datePicker.date)")).to(equal("\(startDate!)"))
                    }
                }
                
                context("when selecting edit button for end date") {
                    beforeEach {
                        subject.datePickerForEndDate()
                    }
                    it("datepicker should have a date as start date") {
                        expect(("\(subject.datePicker.date)")).to(equal("\(endDate!)"))
                    }
                }
                
                context("when selecting edit button for start date") {
                    beforeEach {
                        subject.datePicker(state: LabelTimeCellState.start)
                    }
                    it("datepicker should have a date as start date") {
                        expect(("\(subject.datePicker.date)")).to(equal("\(startDate!)"))
                    }
                }
                
                context("when selecting edit button for end date") {
                    beforeEach {
                        subject.datePicker(state: LabelTimeCellState.end)
                    }
                    it("datepicker should have a date as start date") {
                        expect(("\(subject.datePicker.date)")).to(equal("\(endDate!)"))
                    }
                }
            }
            
        }
    }
}
