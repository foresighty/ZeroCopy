//
//  SettingViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 12/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    var bottomView: UIView!
    var tableView: UITableView!
    var transitionManager: TransitionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.contentInset.top = 15.0
        tableView.backgroundColor = UIColor(red: (235/255), green: (235/255), blue: (235/255), alpha: 1)
        tableView.register(ClearCell.self, forCellReuseIdentifier: "ClearCell")
        bottomView = UIView()
        bottomView.backgroundColor = UIColor(red: (235/255), green: (235/255), blue: (235/255), alpha: 1)
        tableView.tableFooterView = bottomView
        view.addSubview(tableView)
        transitionManager = TransitionManager()
        navigationController?.navigationBar.barTintColor = UIColor(red: (247/255), green: (247/255), blue: (247/255), alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.topItem?.title = "Settings"
        navigationController?.navigationBar.tintColor = .purple
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor  : UIColor.black]
        let leftButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        navigationItem.leftBarButtonItem = leftButton
    }
        
    @objc func donePressed(){
        let transition = transitionManager.transitionDown()
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: false)
    }
}

extension SettingViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let normalCell = UITableViewCell()
        normalCell.accessoryType = .disclosureIndicator
        
        if indexPath.row == 0 {
            normalCell.textLabel?.text = "Fasting Type"
            return normalCell
        }
        
        if indexPath.row == 1 {
            normalCell.textLabel?.text = "Notifications"
            return normalCell
        }
        
        if indexPath.row == 3 {
            normalCell.textLabel?.text = "Export Data"
            return normalCell
        }
        
        if indexPath.row == 4 {
            normalCell.textLabel?.text = "Erase All Data"
            return normalCell
        }
        
        if indexPath.row == 7 {
            normalCell.textLabel?.text = "Oak"
            return normalCell
        }
        
        if indexPath.row == 9 {
            normalCell.textLabel?.text = "Contact Us"
            return normalCell
        }
        
        if indexPath.row == 10 {
            normalCell.textLabel?.text = "Terms of Service"
            return normalCell
        }
        
        if indexPath.row == 11 {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Version"
            cell.accessoryType = .none
            cell.detailTextLabel?.text = "2.0.0"
            cell.detailTextLabel?.textColor = UIColor(red: (200/255), green: (200/255), blue: (200/255), alpha: 1)
            return cell
        }
        
        let clearCell = tableView.dequeueReusableCell(withIdentifier: "ClearCell") as! ClearCell
        return clearCell
    }
}
