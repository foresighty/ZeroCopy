//
//  HomeViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 12/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    var homeHeaderView: HomeHeaderView!
    var tableView: UITableView!
    var transitionManager: TransitionManager!
    
    var fasts: [FastModel]!
    var tableLength: Int!
    
    let constraintRangeForHeaderView = (CGFloat(-190)..<CGFloat(0))
    let constraintRangeForHeaderTransparency = (CGFloat(-130)..<CGFloat(-30))

    var defaultNavigationBarShadow: UIImage!
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitionManager = TransitionManager()
        setupCoreData()
        setupTableView()
        setupHeaderView()
        setupConstraints()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationController()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.shadowImage = defaultNavigationBarShadow
        UIApplication.shared.statusBarStyle = .default
    }
    
    // MARK: Setup
    
    private func setupNavigationController(){
        guard let navigationController = navigationController  else {
            fatalError("navigationController does not exist")
        }
        
        defaultNavigationBarShadow = navigationController.navigationBar.shadowImage
        
        navigationController.navigationBar.topItem?.title = "Zero"
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor  : UIColor.white]
        navigationController.navigationBar.tintColor = .black
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    
        let leftButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsPressed))
        let rightButton = UIBarButtonItem(title: "Science", style: .plain, target: self, action: #selector(sciencePressed))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupTableView(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func setupHeaderView(){
        homeHeaderView = HomeHeaderView()
        view.addSubview(homeHeaderView)
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
    
    // MARK: CoreData
    
    private func setupCoreData() {
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


// MARK: TableViewDataSource Methods:

extension HomeViewController: UITableViewDataSource {
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 12
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                return StartStopCell()
            }
            
            if indexPath.row == 1 {
                return SevenDayTitleCell()
            }
            
            if indexPath.row == 2 {
                return GraphTableViewCell()
            }
            
            if indexPath.row == 3 {
                let cell = ListCell()
                cell.updateDisplayForHeader()
                return cell
            }
            
            if indexPath.row == 10 {
                let cell = ListCell()
                cell.updateDisplayForFooter()
                cell.leftLabel.text = "Average"
                cell.rightLabel.text = "TBD"
                return cell
            }
            
            if indexPath.row == 11 {
                return WarningCell()
            }
            
            
            let cell = ListCell()
            cell.addButton()
            let listOfFasts = CoreDataManager.sharedInstance.retrieveFasts()
            let fast = listOfFasts![indexPath.row-4]
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM"
            let dateStringForCell = formatter.string(from: fast.startTime!)
            cell.leftLabel.text = dateStringForCell
            let duration = fast.duration
            let (h,m) = secondsToHoursMinutes(seconds: Int(duration))
            cell.rightLabel.text = "\(h)hrs \(m)min"
            return cell
            
        }
    
    private func secondsToHoursMinutes(seconds : Int) -> (Int, Int) {
                return (seconds / 3600, (seconds % 3600) / 60)
            }
    }

// MARK: TableViewDelegate Methods

extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let homeHeaderViewTopConstraint = view.constraints[0]
        
        // Compress the top view
        if homeHeaderViewTopConstraint.constant > constraintRangeForHeaderView.lowerBound && scrollView.contentOffset.y > 0 {
            homeHeaderViewTopConstraint.constant -= scrollView.contentOffset.y
            scrollView.contentOffset.y -= scrollView.contentOffset.y
        }
        
        if homeHeaderViewTopConstraint.constant > constraintRangeForHeaderView.upperBound {
            homeHeaderViewTopConstraint.constant = constraintRangeForHeaderView.upperBound
        }
        
        // Expand the top view
        if homeHeaderViewTopConstraint.constant < constraintRangeForHeaderView.upperBound && scrollView.contentOffset.y < 0{
            homeHeaderViewTopConstraint.constant -= scrollView.contentOffset.y
            scrollView.contentOffset.y -= scrollView.contentOffset.y
        }
        
        if homeHeaderViewTopConstraint.constant < constraintRangeForHeaderView.lowerBound {
            homeHeaderViewTopConstraint.constant = constraintRangeForHeaderView.lowerBound
        }

        if homeHeaderViewTopConstraint.constant < constraintRangeForHeaderTransparency.upperBound && homeHeaderViewTopConstraint.constant > constraintRangeForHeaderTransparency.lowerBound {
            let alpha: CGFloat =  (homeHeaderViewTopConstraint.constant + 130)*(1)/(-30+130)
            homeHeaderView.updateLabelsAlpha(with: alpha)
        }
        
        if homeHeaderViewTopConstraint.constant > constraintRangeForHeaderTransparency.upperBound {
            homeHeaderView.updateLabelsAlpha(with: CGFloat(1.0))
        }
        
        if homeHeaderViewTopConstraint.constant < constraintRangeForHeaderTransparency.lowerBound {
            homeHeaderView.updateLabelsAlpha(with: CGFloat(0.0))
        }
    }
}
