//
//  HomeViewDataManagerSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class HomeViewDataManagerSpec: QuickSpec {
    
    override func spec() {
        
        describe("HomeViewDataManager") {
            
            var subject: HomeViewDataManager!
            var mockDelegate: MockHomeViewController!
            var mockHeaderView: MockHeaderView!
            
            beforeEach {
                mockDelegate = MockHomeViewController()
                mockHeaderView = MockHeaderView()
                
                let coreDataHelpers = CoreDataHelpers()
                let managedContext = coreDataHelpers.setUpInMemoryManagedObjectContext()
                CoreDataManager.sharedInstance.managedContext = managedContext
                
                subject = HomeViewDataManager(delegate: mockDelegate, homeHeaderView: mockHeaderView)
                
            }
            
            context("when initialised") {
                it("should exist") {
                    expect(subject).toNot(beNil())
                }
                it("is provided a delegate") {
                    expect(subject.delegate).to(be(mockDelegate))
                }
                it("is provided a home header view") {
                    expect(subject.homeHeaderView).to(be(mockHeaderView))
                }
            }
            
            context("when timer needs to start") {
                beforeEach {
                    subject.runTimer()
                }
                it("should tell the home header view") {
                    expect(mockHeaderView.didStartTiming).to(beTrue())
                }
            }
            
            context("when presenting a save fast view controller") {
                
                let completeButtonPress = {}
                
                beforeEach {
                    subject.presentSaveFastViewContoller(closure: completeButtonPress)
                }
                
                it("should pass the delegate a configured saveFastViewController") {
                    expect(mockDelegate.passedViewController).toNot(beNil())
                    expect(mockDelegate.passedViewController?.completeButtonPress).toNot(beNil())
                    expect(mockDelegate.passedViewController?.homeHeaderView).to(be(mockHeaderView))
                    expect(mockDelegate.passedViewController?.startDate).toNot(beNil())
                    expect(mockDelegate.passedViewController?.endDate).toNot(beNil())
                }
            }
            
            context("when a list cell button is pressed") {
                
                var listOfFasts: [Fast]!
                var fast: Fast!
                
                beforeEach {
                    
                    CoreDataManager.sharedInstance.recordFast(startDate: Date(), endDate: Date())
                    CoreDataManager.sharedInstance.recordFast(startDate: Date(), endDate: Date())
                    
                    listOfFasts = CoreDataManager.sharedInstance.retrieveFasts()
                    
                    fast = listOfFasts[1]
                    subject.didTap(at: 1)
                }
                
                it("should present the view controller for that fast") {
                    expect(mockDelegate.passedViewController?.fast).to(be(fast))
                }
                
                
            }
        }
    }
}

fileprivate class MockHomeViewController: HomeViewDataManagerDelegate {
    
    var passedViewController: SaveFastViewController?
    
    func present(_ saveFastViewController: SaveFastViewController) {
        passedViewController = saveFastViewController
    }
    
}

fileprivate class MockHeaderView: HomeHeaderView {
    var didStartTiming: Bool = false

    override func startTiming() {
        didStartTiming = true
    }
}
