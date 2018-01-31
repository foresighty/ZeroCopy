//
//  GraphTableViewCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 26/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class GraphTableViewCell: UITableViewCell {
    
    // TODO: This Cell
    var graphView: UIView!

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
        
        graphView = UIView()
        graphView.layer.borderColor = UIColor.black.cgColor
        graphView.layer.borderWidth = 0.5
        graphView.layer.cornerRadius = 1
        graphView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(graphView)
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        let constraints : [NSLayoutConstraint] = [
            contentView.heightAnchor.constraint(equalToConstant: 200.0),
            graphView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            graphView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0),
            graphView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            graphView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
