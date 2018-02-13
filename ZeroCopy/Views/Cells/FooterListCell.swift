//
//  FooterListCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 30/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class FooterListCell: ListCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = UIColor(red:0.82, green:0.81, blue:0.82, alpha:1.0)
        editButton?.removeFromSuperview()
    }
    
    public func configForAverage(with fasts: [Fast]) {
        leftLabel.text = "Average"

        var total: Int = 0
        
        for fast in fasts {
            total += fast.duration
        }
        
        let average = total / Int(fasts.count)
        
        let (h,m) = secondsToHoursMinutes(seconds: average)
        rightLabel.text = "\(h)hrs \(m)min"
    }
    
    public func configForTotal(with fasts: [Fast]) {
        leftLabel.text = "Total"

        var total: Int = 0
        
        for fast in fasts {
            total += fast.duration
        }
        
        let (h,m) = secondsToHoursMinutes(seconds: total)
        rightLabel.text = "\(h)hrs \(m)min"
    }
    
    private func secondsToHoursMinutes(seconds : Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
    }
    
}


