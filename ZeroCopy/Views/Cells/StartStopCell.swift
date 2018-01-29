//
//  StartStopCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 26/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class StartStopCell: UITableViewCell {

    var fastingButton: UIButton!
    var lastSevenLabel: UILabel!
    
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
        
        let selectedTextColor = UIColor(red:0.45, green:0.44, blue:0.31, alpha:1.0)

        fastingButton = UIButton()
        fastingButton.setTitle("Start Fasting", for: .normal)
        fastingButton.setTitleColor(selectedTextColor, for: .selected)
        fastingButton.setTitle("Stop Fasting", for: .selected)
        fastingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        fastingButton.backgroundColor = UIColor(red: 0.59, green: 0.78, blue: 0.82, alpha: 1.0)
        fastingButton.translatesAutoresizingMaskIntoConstraints = false
        fastingButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        contentView.addSubview(fastingButton)
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        setupConstraints()
    }
    
    private func setupConstraints(){
        let constraints: [NSLayoutConstraint] = [
            contentView.heightAnchor.constraint(equalToConstant: 90.0),
            fastingButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            fastingButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            fastingButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            fastingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25.0)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func pressed(){
        fastingButton.isSelected = fastingButton.isSelected ? false : true
        let normalColor = UIColor(red: 0.59, green: 0.78, blue: 0.82, alpha: 1.0)
        let selectedColor = UIColor(red:0.90, green:0.89, blue:0.60, alpha:1.0)
        
        fastingButton.backgroundColor = fastingButton.isSelected ? selectedColor : normalColor
        fastingButton.titleLabel?.textColor = fastingButton.isSelected ? .black : .white
    }
    
}


