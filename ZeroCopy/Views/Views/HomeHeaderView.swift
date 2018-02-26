//
//  HomeHeaderView.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 24/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

enum HomeHeaderState {
    case normal
    case fasting
}

class HomeHeaderView: UIView, TimerDelegate {

    private var backgroundImageView: UIImageView!
    private var goalLabel: UILabel!
    private var tagline: UILabel!
    var timerDescription: UILabel?
    var timerText: UILabel?
    var state: HomeHeaderState?
    var dateFormatter = DateFormatter()
    var fastTimer: FastTimer!
    
    // MARK: Initialisers

    init(with timer: FastTimer) {
        super.init(frame: CGRect())
        self.fastTimer = timer
        self.fastTimer.delegate = self
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        dateFormatter.dateFormat = "HH:mm:ss"
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
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func setupTimingView() {
        timerDescription = UILabel()
        timerText = UILabel()
        
        guard let timerDescription = timerDescription else { return }
        guard let timerText = timerText else { return }
        
        timerDescription.translatesAutoresizingMaskIntoConstraints = false
        timerDescription.text = "ELAPSED TIME"
        timerDescription.font = UIFont(name: goalLabel.font.fontName, size: 14)
        timerDescription.textAlignment = .center
        timerText.translatesAutoresizingMaskIntoConstraints = false
        timerText.text = "00:00:00"
        timerText.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight.thin)
        timerText.textColor = .white
        timerText.textAlignment = .center

        addSubview(timerDescription)
        addSubview(timerText)
        
        let constraints:[NSLayoutConstraint] = [
            timerDescription.topAnchor.constraint(equalTo: self.topAnchor, constant: 124.0),
            timerDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timerDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            timerText.topAnchor.constraint(equalTo: timerDescription.bottomAnchor, constant: 15.0),
            timerText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timerText.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: Timer Delegate Methods
    
    func updateView(with seconds: Int) {
        timerText?.text = stringFromTimeInterval(total: seconds)
    }
    
    
    // MARK: Private Methods
    
    private func stringFromTimeInterval(total: Int) -> String {
        let seconds = total % 60
        let minutes = (total / 60) % 60
        let hours = (total / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // MARK: Public methods
    
    public func updateLabelsAlpha(with alpha: CGFloat) {
        goalLabel.textColor = goalLabel.textColor.withAlphaComponent(alpha)
        tagline.textColor = tagline.textColor.withAlphaComponent(alpha)
        timerText?.textColor = timerText?.textColor.withAlphaComponent(alpha)
        timerDescription?.textColor = timerDescription?.textColor.withAlphaComponent(alpha)
    }
    
    public func startTiming() {
        goalLabel.removeFromSuperview()
        tagline.removeFromSuperview()
        setupTimingView()
    }
    
    public func stopTiming() {
        setupGoalLabel()
        setupTagLineLabel()
        setupConstraints()
    }
}

