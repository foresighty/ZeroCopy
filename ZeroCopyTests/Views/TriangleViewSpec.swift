//
//  TriangleViewSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class TriangleViewSpec: QuickSpec {
    
    override func spec() {
        
        describe("TriangleView") {
        
            var subject: TriangleView!
            
            beforeEach {
                subject = TriangleView()
            }
            
            context("when creating triangle view") {
                it("should be a view"){
                    expect(subject).to(beAKindOf(UIView.self))
                }
                it("should not be nil"){
                    expect(subject).toNot(beNil())
                }
            }
        }

    }
}
