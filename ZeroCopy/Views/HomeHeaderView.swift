//
//  HomeHeaderView.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 24/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    var backgroundImageView: UIImageView!
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
        setupBackgroundImageView()
        setupGoalLabel()
        setupTagLineLabel()
        setupConstraints()
    }
    
    private func setupBackgroundImageView(){
        let imageName = "headerBackground.png"
        let image = UIImage(named: imageName)
        backgroundImageView = UIImageView(image: image!)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        //backgroundImageView.contentMode = .scaleAspectFill
        //backgroundImageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 269)
    }
    
    private func setupGoalLabel(){
        goalLabel = UILabel()
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.text = "Goal: 16 hours"
        goalLabel.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.thin)
        goalLabel.textColor = .white
        goalLabel.textAlignment = .center
    }
    
    private func setupTagLineLabel() {
        tagline = UILabel()
        tagline.translatesAutoresizingMaskIntoConstraints = false
        tagline.text = "Today is a beautiful day to fast."
        tagline.font = UIFont(name: goalLabel.font.fontName, size: 12)
        tagline.textAlignment = .center
    }
    
    private func setupConstraints() {
        addSubview(backgroundImageView)
        addSubview(goalLabel)
        addSubview(tagline)


        let constraints:[NSLayoutConstraint] = [
            self.heightAnchor.constraint(equalToConstant: 254.0),
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            goalLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 134.0),
            goalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            goalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tagline.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 10.0),
            tagline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tagline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //tagline.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50.0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }

}

