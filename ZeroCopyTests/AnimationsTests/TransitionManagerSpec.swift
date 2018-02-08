//
//  TransitionManagerSpec
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 07/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble
import UIKit

@testable import ZeroCopy

class TransitionManagerSpec: QuickSpec {
    
    override func spec() {
        
        describe("TransitionManager") {
            
            let subject = TransitionManager()
            
            context("when transition up is called"){
                var transition: CATransition?
                
                beforeEach {
                    transition = subject.transitionUp()
                }
                
                it("returned transition should not be nil"){
                    expect(transition).toNot(beNil())
                }
            }
            
            context("when transition down is called"){
                var transition: CATransition?
                
                beforeEach {
                    transition = subject.transitionDown()
                }
                
                it("returned transition should not be nil"){
                    expect(transition).toNot(beNil())
                }
            }
        }
    }
}
