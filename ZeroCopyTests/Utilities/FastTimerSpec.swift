//
//  FastTimerSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class FastTimerSpec: QuickSpec {
    
    override func spec() {
        
        describe("FastTimer") {
            
            var subject: FastTimer!
            
            beforeEach {
                subject = FastTimer()
            }
            
            context("when the timer is started") {
                
                beforeEach {
                    subject.runTimer()
                }
                
                it("should create a timer") {
                    expect(subject.timer).toNot(beNil())
                }
                it("should set timer to isRunning") {
                    expect(subject.isRunning).to(beTrue())
                }
                it("should record the current date as the start date") {
                    expect(subject.startDate).to(beCloseTo(Date()))
                }
                
            }
            
            context("when the timer is running") {
                
                var mockDelegate: MockTimerDelegate!
                
                beforeEach {
                    mockDelegate = MockTimerDelegate()
                    subject.delegate = mockDelegate
                    subject.runTimer()
                }
                
                it("should call delegate updateView method"){
                    expect(mockDelegate.secondsReceived).toEventually(beGreaterThan(0), timeout: 1.1)
                }
            }
            
            context("when the timer is stopped") {
                beforeEach {
                    subject.runTimer()
                    subject.cancelTimer()
                }
                
                it("should set seconds to 0") {
                    expect(subject.seconds).to(equal(0))
                }
                it("should set the timer as not running") {
                    expect(subject.isRunning).to(beFalse())
                }
            }
            
            context("when the timer finishes") {
                
                let startDate = Date()
                var endDate = Date()
                var returnedStartDate = Date()
                var returnedEndDate = Date()
                
                beforeEach {
                    subject.startDate = startDate
                    
                    endDate = Date()
                    (returnedStartDate, returnedEndDate) = subject.getTimerDates()
                }
                
                it("should provide start and end dates") {
                    expect(returnedStartDate).to(equal(startDate))
                    expect(returnedEndDate).to(beCloseTo(endDate))
                }
            }
        }
    }
}

fileprivate class MockTimerDelegate: TimerDelegate {
    var secondsReceived: Int = 0
    
    func updateView(with seconds: Int) {
        secondsReceived = seconds
    }
}
