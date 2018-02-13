//
//  ClearCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 13/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class ClearCell: UITableViewCell {
    
    var label: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        NSLayoutConstraint.activate([contentView.heightAnchor.constraint(equalToConstant: 20.0)])
    }
}
