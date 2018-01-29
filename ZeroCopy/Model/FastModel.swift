//
//  FastModel.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 29/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Foundation

struct Fasts: Codable {
    let fasts: [FastModel]
}

struct FastModel: Codable {
    var startTime: Date?
    var endTime: Date?
}
