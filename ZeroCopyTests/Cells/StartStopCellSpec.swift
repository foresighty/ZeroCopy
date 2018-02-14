//
//  StartStopCellSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class StartStopCellSpec: QuickSpec {
    
    override func spec() {
        
        describe("Start Stop Cell") {
            
            var subject: StartStopCell!
            
            beforeEach {
                subject = StartStopCell()
            }
            
            context("when creating a cell") {
                it("cell should not be nil") {
                    expect(subject).notTo(beNil())
                }
            }
            
            context("when button is press to start a fast") {
                
                var mockDelegate: MockStartStopCellDelegate!
                
                beforeEach {
                    mockDelegate = MockStartStopCellDelegate()
                    subject.delegate = mockDelegate
                    
                    subject.fastingButton.isSelected = false
                    subject.fastingButton.sendActions(for: .touchUpInside)
                }
                
                it("should call runtimer method on delegate") {
                    expect(mockDelegate.didCallDelegateRunTimer).to(beTrue())
                    expect(mockDelegate.didCallDelegatePresentMethod).toNot(beTrue())
                }
            }
            
            context("when button is press to end a fast") {
                
                var mockDelegate: MockStartStopCellDelegate!
                
                beforeEach {
                    mockDelegate = MockStartStopCellDelegate()
                    subject.delegate = mockDelegate
                    
                    subject.fastingButton.isSelected = true
                    subject.fastingButton.sendActions(for: .touchUpInside)
                }
                
                it("should call runtimer method on delegate") {
                    expect(mockDelegate.didCallDelegateRunTimer).toNot(beTrue())
                    expect(mockDelegate.didCallDelegatePresentMethod).to(beTrue())
                }
            }
        }
    }
}

fileprivate class MockStartStopCellDelegate: StartStopCellDelegate {
    var didCallDelegatePresentMethod: Bool = false
    var didCallDelegateRunTimer: Bool = false
    
    func presentSaveFastViewContoller(closure: @escaping () -> Void) {
        didCallDelegatePresentMethod = true
    }
    
    func runTimer() {
        didCallDelegateRunTimer = true
    }
}
