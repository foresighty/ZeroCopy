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
        addButton()
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
    
    private func addButton() {
        let editImage = UIImage(named: "editPencil")
        editButton = UIButton()
        editButton?.setImage(editImage, for: .normal)   
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
    
    public func updateDisplay(with fast: Fast){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        
        if let startTime = fast.startDate {
            let dateStringForCell = formatter.string(from: startTime)
            leftLabel.text = dateStringForCell
            let duration = fast.duration
            let (h,m) = secondsToHoursMinutes(seconds: Int(duration))
            // Replace line below with this for hour to minutes: cell.rightLabel.text = "\(h)hrs \(m)min"
            rightLabel.text = "\(duration)"
        }
    }
    
    public func isDefault(){
        leftLabel.text = "Left Label"
        rightLabel.text = "Right Label"
    }
    
    private func secondsToHoursMinutes(seconds : Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
    }
}
