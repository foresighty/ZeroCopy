//
//  HeaderListCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 30/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class HeaderListCell: ListCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        leftLabel.text = "Started"
        rightLabel.text = "Duration"
        leftLabel.text = leftLabel.text?.uppercased()
        rightLabel.text = rightLabel.text?.uppercased()
        leftLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        rightLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        editButton?.removeFromSuperview()
    }
}

