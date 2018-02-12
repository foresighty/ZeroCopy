//
//  LabelAndTimeCell.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 02/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

protocol DatePickerProtocol {
    func datePicker(state: LabelTimeCellState)
}

enum LabelTimeCellState: Int {
    case start
    case end
    case total
}

class LabelAndTimeCell: UITableViewCell {
    
    var topLabel: UILabel!
    var bottomLabel: UILabel!
    var editButton: UIButton?
    var delegate: DatePickerProtocol?
    var state: LabelTimeCellState = .total

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
    
    public func isStart() {
        topLabel.text = "STARTED"
        enableEditButton()
        state = .start
    }
    
    public func isEnd() {
        topLabel.text = "ENDED"
        enableEditButton()
        state = .end
    }
    
    private func enableEditButton() {
        editButton = UIButton()
        guard let editButton = editButton else { return }
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.purple, for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(editButton)
        let constraints:[NSLayoutConstraint] = [
            editButton.centerYAnchor.constraint(equalTo: bottomLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30.0)
        ]
        NSLayoutConstraint.activate(constraints)
        
        editButton.addTarget(self, action: #selector(displayDatePicker), for: .touchUpInside)
    }
    
    @objc private func displayDatePicker() {
        delegate?.datePicker(state: state)
    }
}
