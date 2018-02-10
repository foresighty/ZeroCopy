//
//  ScienceViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 12/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit
import SafariServices

class ScienceViewController: UIViewController {
    
    var tableView: UITableView!
    var transitionManager: TransitionManager!
    
    override func viewDidLoad() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        transitionManager = TransitionManager()
        guard let navigationController = navigationController else { fatalError() }
        navigationController.navigationBar.barTintColor = UIColor(red: (247/255), green: (247/255), blue: (247/255), alpha: 1)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.topItem?.title = "Learn More"
        navigationController.navigationBar.tintColor = .purple
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor  : UIColor.black]
        let leftButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.fade)
    }
    
    @objc func donePressed(){
        let transition = transitionManager.transitionDown()
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: false)
    }
    
}

extension ScienceViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        if indexPath.row == 0 {
            cell.textLabel?.text = "Video: Dr. Satchin Panda on Time-Restricted Feeding and Its Effects on Obesity, Muscle Mass & Heart Health"
            cell.accessoryType = .disclosureIndicator
        }
        
        if indexPath.row == 1 {
            cell.textLabel?.text = "Video: Valter Longo, Ph.D. on Fasting-Mimicking Diet & Fasting for Longevity, Cancer  & Multiple Sclerosis"
            cell.accessoryType = .disclosureIndicator
        }
        
        if indexPath.row == 2 {
            cell.textLabel?.text = "Video: Ruth Patterson, Ph.D. on Time-Restricted Eating in Humans & Breast Cancer Prevention"
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    
}

extension ScienceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var url = URL(string: "")
        
        if indexPath.row == 0 {
            url = URL(string: "https://www.youtube.com/watch?v=-R-eqJDQ2nU")
        }
        if indexPath.row == 1 {
            url = URL(string: "https://www.youtube.com/watch?v=d6PyyatqJSE")
        }
        if indexPath.row == 2 {
            url = URL(string: "https://www.youtube.com/watch?v=8qlrB84xp5g")
        }
        
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
}
