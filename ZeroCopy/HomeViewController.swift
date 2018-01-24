//
//  HomeViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 12/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var tableView: UITableView!
    var transitionManager: TransitionManager!
    
    override func viewDidLoad() {
        setup()
        setupTableView()
        setupNavigationController()
    }
    
    // MARK: Setup
    
    private func setup(){
        transitionManager = TransitionManager()
    }
    
    private func setupTableView(){
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    private func setupNavigationController(){
        navigationController?.navigationBar.topItem?.title = "Zero"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor  : UIColor.white]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 248/255, green: 110/255, blue: 92/255, alpha: 1.0)
        let leftButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsPressed))
        let rightButton = UIBarButtonItem(title: "Science", style: .plain, target: self, action: #selector(sciencePressed))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: Button Methods
    
    @objc func settingsPressed(){
        let transition = transitionManager.transitionUp()
        navigationController!.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(SettingViewController(), animated: false)
    }
    
    @objc func sciencePressed(){
        let transition = transitionManager.transitionUp()
        navigationController!.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(ScienceViewController(), animated: false)
    }
}

// MARK: TableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let label = UILabel(frame: CGRect(x: 30.0, y: 10.0, width: 100.0, height: 20.0))
            label.text = String(indexPath.row)
            let cell = UITableViewCell()
            cell.addSubview(label)
            return cell
    }

}


// MARK: TableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TableViewHeader()
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 200.0
//        }
//        return 44
//    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y >= -64.0 {
//
//            scrollView.isScrollEnabled = true
//        } else {
//            scrollView.isScrollEnabled = false
//            scrollView.contentOffset.y = -64.0
//        }
//        print(abs(scrollView.contentOffset.y))
//    }
}
