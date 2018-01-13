//
//  TransitionManager.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 13/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class TransitionManager {
    
    public func transitionUp() -> CATransition {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        return transition
    }
    
    public func transitionDown() -> CATransition {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        return transition
    }
    
}
