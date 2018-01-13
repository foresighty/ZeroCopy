//
//  ScienceViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 12/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class ScienceViewController: UIViewController {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        navigationController?.navigationBar.topItem?.title = "Learn more"
        let leftButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func donePressed(){
        transitionDown()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Transitions
    private func transitionDown(){
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        navigationController!.view.layer.add(transition, forKey: nil)
    }
}

extension ScienceViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

