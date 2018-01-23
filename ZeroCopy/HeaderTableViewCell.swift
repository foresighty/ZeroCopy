//
//  HeaderTableViewCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 23/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    var goalLabel: UILabel!
    var tagline: UILabel!

    
    // TODO: State for cell - fasting vs not fasting
    
    // MARK: Initialisers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup(){
        
        backgroundColor = .orange
        
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

        if goalLabel.superview != nil {
            let views : [String : Any] = [
                "goalLabel" : goalLabel,
                "tagline" : tagline
            ]
            
            var allConstraints : [NSLayoutConstraint] = []
            
            let horizontalGoalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[goalLabel]-|", options: .alignAllTop, metrics: nil, views: views)
            let horizontalTaglineConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tagline]-|", options: .alignAllTop, metrics: nil, views: views)
            let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[goalLabel]-5-[tagline]-70-|", options: .alignAllCenterX, metrics: nil, views: views)
            
            allConstraints += horizontalGoalConstraints
            allConstraints += horizontalTaglineConstraints
            allConstraints += verticalConstraints
            
            NSLayoutConstraint.activate(allConstraints)
        }   
    }
    
}
