//
//  LabelAndTimeCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 02/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class LabelAndTimeCell: UITableViewCell {
    
    var topLabel: UILabel!
    var bottomLabel: UILabel!

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
        
        topLabel = UILabel()
        topLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel = UILabel()
        bottomLabel.font = UIFont.systemFont(ofSize: 20.0)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        setupConstraints()
    }

    private func setupConstraints() {
        let constraints:[NSLayoutConstraint] = [
            contentView.heightAnchor.constraint(equalToConstant: 120.0),
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30.0),
            topLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30.0),
            bottomLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
