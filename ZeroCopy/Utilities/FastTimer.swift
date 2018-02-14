//
//  FastTimer.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 30/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Foundation

// TODO: Change timer to count time since start date and display

class FastTimer {
    var seconds = 0
    var timer = Timer()
    var isRunning = false
    var startDate = Date()
    var endDate = Date()
    
    public func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isRunning = true
        startDate = Date()
    }
    
    @objc private func updateTimer(){
        seconds += 1
    }
    
    public func stopTimer(){
        timer.invalidate()
        //let secondsToSend = seconds
        seconds = 0
        isRunning = false
        //endDate = Date()
        //return (startDate, endDate)
        //return (startDate, endDate, secondsToSend)
    }
    
    public func getTimerDates() -> (Date, Date) {
        endDate = Date()
        return (startDate, endDate)
    }
}
