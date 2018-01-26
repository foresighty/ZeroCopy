//
//  SevenDayTitleCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 26/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class SevenDayTitleCell: UITableViewCell {

    var lastSevenLabel: UILabel!
    var lineView: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectionStyle = .none
        
        lastSevenLabel = UILabel()
        lastSevenLabel.text = "  LAST 7 FASTS  "
        lastSevenLabel.backgroundColor = .white
        lastSevenLabel.font = lastSevenLabel.font.withSize(10.0)
        lastSevenLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView = UIView()
        lineView.backgroundColor = UIColor(red:0.82, green:0.81, blue:0.82, alpha:1.0)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(lineView)
        contentView.addSubview(lastSevenLabel)
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)

        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let constraints:[NSLayoutConstraint] = [
            contentView.heightAnchor.constraint(equalToConstant: 14.0),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            lineView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            lastSevenLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lastSevenLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    

}
