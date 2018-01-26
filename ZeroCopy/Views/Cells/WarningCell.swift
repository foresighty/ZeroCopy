//
//  WarningCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 26/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class WarningCell: UITableViewCell {

    var warningLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectionStyle = .none
        
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: .greatestFiniteMagnitude)
        
        warningLabel = UILabel()
        warningLabel.text = "Talk to your doctor before fasting"
        warningLabel.textColor = UIColor(red:0.82, green:0.81, blue:0.82, alpha:1.0)
        warningLabel.font = warningLabel.font.withSize(12.0)
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(warningLabel)
        
        let constraints : [NSLayoutConstraint] = [
            contentView.heightAnchor.constraint(equalToConstant: 44.0),
            warningLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            warningLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
