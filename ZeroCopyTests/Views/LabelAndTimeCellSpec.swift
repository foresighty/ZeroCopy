//
//  LabelAndTimeCellSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class LabelAndTimeCellSpec: QuickSpec {
    
    override func spec() {
        
        describe("Label and Time Cell") {
            
            var subject: LabelAndTimeCell!
            
            beforeEach {
                subject = LabelAndTimeCell()
            }
            
            context("when creating a cell") {
                it("cell should not be nil") {
                    expect(subject).notTo(beNil())
                }
                it("should have a top label, bottom label") {
                    expect(subject.topLabel).notTo(beNil())
                    expect(subject.bottomLabel).notTo(beNil())
                }
                it("should not have a button"){
                    expect(subject.editButton).to(beNil())
                }
                it("default state should be total") {
                    expect(subject.state).to(equal(LabelTimeCellState.total))
                }
            }
            
            context("when configuring cell state as start") {
                beforeEach {
                    subject.isStart()
                }
                
                it("the top label should be STARTED") {
                    expect(subject.topLabel.text).to(equal("STARTED"))
                }
                it("should have an Edit Button") {
                    expect(subject.editButton).toNot(beNil())
                }
            }
            
            context("when configuring cell state as end") {
                beforeEach {
                    subject.isEnd()
                }
                
                it("the top label should be ENDED") {
                    expect(subject.topLabel.text).to(equal("ENDED"))
                }
                it("should have an Edit Button") {
                    expect(subject.editButton).toNot(beNil())
                }
            }
            
            context("when cell has an edit button and button is pressed") {
                
                var mockDelegate: MockDatePicker!
                
                beforeEach {
                    subject.isStart()
                    mockDelegate = MockDatePicker()
                    subject.delegate = mockDelegate
                    subject.editButton?.sendActions(for: .touchUpInside)
                }
                
                it("should call datePicker method on delegate") {
                    expect(mockDelegate.didCallDatePicker).to(beTrue())
                }
                
            }
        }
    }
}

fileprivate class MockDatePicker: DatePickerProtocol {
    var didCallDatePicker: Bool = false
    
    func datePicker(state: LabelTimeCellState) {
        didCallDatePicker = true
    }
}
