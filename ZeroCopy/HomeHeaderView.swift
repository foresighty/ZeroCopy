//
//  HomeHeaderView.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 24/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    var goalLabel: UILabel!
    var tagline: UILabel!
    
    // TODO: State - fasting vs not fasting
    
    // MARK: Initialisers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup(){
        

        translatesAutoresizingMaskIntoConstraints = false
        
        goalLabel = UILabel()
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.text = "Goal: 16 hours"
        goalLabel.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.thin)
        goalLabel.textColor = .white
        goalLabel.textAlignment = .center
        
        tagline = UILabel()
        tagline.translatesAutoresizingMaskIntoConstraints = false
        tagline.text = "Today is a beautiful day to fast."
        tagline.font = UIFont(name: goalLabel.font.fontName, size: 12)
        tagline.textAlignment = .center
        addSubview(goalLabel)
        addSubview(tagline)
    
            let constraints:[NSLayoutConstraint] = [
                goalLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 134.0),
                goalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                goalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tagline.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 10.0),
                tagline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tagline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tagline.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70.0)
            ]
            NSLayoutConstraint.activate(constraints)
        

    }
}

