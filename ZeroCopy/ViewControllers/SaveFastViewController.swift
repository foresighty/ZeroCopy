//
//  SaveFastViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 01/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class SaveFastViewController: UIViewController {
    
    var tableView: UITableView!
    var saveButton: UIButton!
    var fast: Fast?
    var transitionManager: TransitionManager!
    var dateFormatter: DateFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationController()
        setupConstraints()
    }
    
    private func setup() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mmpo"
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LabelAndTimeCell.self, forCellReuseIdentifier: "LabelAndTimeCell")
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .blue
        saveButton.setTitle("Save Fast", for: .normal)
        transitionManager = TransitionManager()
        
        view.addSubview(saveButton)
        view.addSubview(tableView)
    }
    
    private func setupNavigationController() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.barTintColor = UIColor(red: (247/255), green: (247/255), blue: (247/255), alpha: 1)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.topItem?.title = "Finish Fast"
        navigationController.navigationBar.tintColor = .purple
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor  : UIColor.black]
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let rightButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deletePressed))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func cancelPressed(){
        let transition = transitionManager.transitionDown()
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: false)
    }
    
    @objc func deletePressed(){
    }
    
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 80.0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension SaveFastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fast = fast else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelAndTimeCell") as! LabelAndTimeCell
            cell.topLabel.text = "STARTED"
            cell.bottomLabel.text = dateFormatter.string(from: fast.startDate!)
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelAndTimeCell") as! LabelAndTimeCell
            cell.topLabel.text = "ENDED"
            cell.bottomLabel.text = dateFormatter.string(from: fast.endDate!)
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelAndTimeCell") as! LabelAndTimeCell
            cell.topLabel.text = "TOTAL FASTING TIME"
            cell.bottomLabel.text = "\(fast.duration) seconds"
            return cell
        }
        
        return UITableViewCell()
    }
}
