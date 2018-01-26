//
//  ListCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 26/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    // Labels
    var leftLabel: UILabel!
    var rightLabel: UILabel!
    var editButton: UIButton?

    // States
    var isHeader = false
    var isFooter = false
    var hasButton = false
    
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
        
        separatorInset = UIEdgeInsetsMake(0.0, 20.0, 0.0, 20.0)
        
        leftLabel = UILabel()
        leftLabel.text = "Left Label"
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.font = leftLabel.font.withSize(12.0)

        rightLabel = UILabel()
        rightLabel.text = "Right Label"
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.font = rightLabel.font.withSize(12.0)

        
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        setupConstraints()
        
        if hasButton {
            addButton()
        }
        
        if isHeader {
            updateDisplayForHeader()
        }
        
        if isFooter {
            updateDisplayForFooter()
        }
        
        
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            leftLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            leftLabel.widthAnchor.constraint(equalToConstant: 150.0),
            rightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 10.0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    public func updateDisplayForHeader() {
        leftLabel.text = "Started"
        rightLabel.text = "Duration"
        leftLabel.text = leftLabel.text?.uppercased()
        rightLabel.text = rightLabel.text?.uppercased()
        leftLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        rightLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
    }
    
    public func updateDisplayForFooter() {
        contentView.backgroundColor = UIColor(red:0.82, green:0.81, blue:0.82, alpha:1.0)
    }
    
    public func addButton() {
        editButton = UIButton()
        editButton?.backgroundColor = UIColor(red:0.82, green:0.81, blue:0.82, alpha:1.0)
        editButton?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(editButton!)
        let constraints: [NSLayoutConstraint] = [
            editButton!.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editButton!.heightAnchor.constraint(equalToConstant: 12.0),
            editButton!.widthAnchor.constraint(equalToConstant: 12.0),
            editButton!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0)
        ]
        NSLayoutConstraint.activate(constraints)

    }
    
    
}
