//
//  ClearCellSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class ClearCellSpec: QuickSpec {
    
    override func spec() {
        
        var subject: ClearCell!
        
        describe("ClearCell") {
            
            beforeEach {
                subject = ClearCell()
            }
            
            context("when cell is created") {
                it("should configure a cell correctly") {
                    expect(subject).toNot(beNil())
                    expect(subject.selectionStyle).to(equal(UITableViewCellSelectionStyle.none))
                    expect(subject.backgroundColor).to(equal(UIColor.clear))
                }
            }
        }
    }
}
