//
//  FastDataModel.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 30/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Foundation

struct FastDataModel  {
    var startDate: Date?
    var endDate: Date?
    var duration: Int? {
        var durationDouble : Double = 0
        if let startDate = startDate, let endDate = endDate {
            durationDouble = endDate.timeIntervalSince(startDate)
        }
        let duration: Int = Int(durationDouble)
        return duration
    }
}
