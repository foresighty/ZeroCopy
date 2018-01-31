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
        leftLabel.text = "Average"
        rightLabel.text = "TBD"
        contentView.backgroundColor = UIColor(red:0.82, green:0.81, blue:0.82, alpha:1.0)
        editButton?.removeFromSuperview()
    }
}