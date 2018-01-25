//
//  HomeViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 12/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeHeaderView: HomeHeaderView!
    var tableView: UITableView!
    var transitionManager: TransitionManager!
    
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(-70)..<CGFloat(134))
    
    override func viewDidLoad() {
        setup()
        setupTableView()
        setupHeaderView()
        setupNavigationController()
        setupConstraints()
    }
    
    // MARK: Setup
    
    private func setup(){
        transitionManager = TransitionManager()
    }
    
    private func setupHeaderView(){
        homeHeaderView = HomeHeaderView()
        homeHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeHeaderView)
    }
    
    private func setupTableView(){
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func setupConstraints() {
        let constraints:[NSLayoutConstraint] = [
            homeHeaderView.topAnchor.constraint(equalTo: view.topAnchor),
            homeHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: homeHeaderView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyBackgroundImageToHeader()
    }
    
    private func applyBackgroundImageToHeader() {
        UIGraphicsBeginImageContext(homeHeaderView.frame.size)
        UIImage(named: "headerBackground.png")?.draw(in: homeHeaderView.bounds)
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            homeHeaderView.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
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
//        if section == 0 {
//            return 0
//        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let constraint = homeHeaderView.constraints[0]
        
        // Compress the top view
        if constraint.constant > topConstraintRange.lowerBound && scrollView.contentOffset.y > 0 {
            print("Constraint const = \(constraint.constant)")
            print("Scroll view content offset = \(scrollView.contentOffset.y)")
            constraint.constant -= scrollView.contentOffset.y
            scrollView.contentOffset.y -= scrollView.contentOffset.y
        }
        
        // Expand the top view
        if constraint.constant < topConstraintRange.upperBound && scrollView.contentOffset.y < 0{
            print("Constraint const = \(constraint.constant)")
            print("Scroll view content offset = \(scrollView.contentOffset.y)")
            constraint.constant -= scrollView.contentOffset.y
            scrollView.contentOffset.y -= scrollView.contentOffset.y
        }
        
        if constraint.constant > topConstraintRange.upperBound {
            constraint.constant = topConstraintRange.upperBound
        }
        
        if constraint.constant < topConstraintRange.lowerBound {
            constraint.constant = topConstraintRange.lowerBound
        }
    }
    
    
}
