//
//  TransitionManager.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 13/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class TransitionManager {
    
    private var transition = CATransition()
    
    public func transitionUp() -> CATransition {
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        return transition
    }
    
    public func transitionDown() -> CATransition {
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        return transition
    }
}
