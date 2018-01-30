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
        
        tableView.register(StartStopCell.self, forCellReuseIdentifier: "StartStopCell")
        tableView.register(SevenDayTitleCell.self, forCellReuseIdentifier: "SevenDayTitleCell")
        tableView.register(GraphTableViewCell.self, forCellReuseIdentifier: "GraphTableViewCell")
        tableView.register(WarningCell.self, forCellReuseIdentifier: "WarningCell")
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        
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

extension HomeViewController: UITableViewDataSource, StartStopCellUpdater {
    
        func updateTableView() {
            tableView.reloadData()
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 12
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "StartStopCell") as! StartStopCell
                cell.delegate = self
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SevenDayTitleCell") as! SevenDayTitleCell
                return cell
            }
            
            if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell") as! GraphTableViewCell
                return cell
            }
            
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarningCell") as! WarningCell
                return cell
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
            cell.addButton()
            guard let listOfFasts = CoreDataManager.sharedInstance.retrieveFasts() else { return cell }
            var fast = Fast()
            if listOfFasts.count > 0 && indexPath.row-4 < listOfFasts.count {
                fast = listOfFasts[indexPath.row-4]
                
                if let startTime = fast.startDate {
                    let dateStringForCell = formatter.string(from: startTime)
                    cell.leftLabel.text = dateStringForCell
                    let duration = fast.duration
                    let (h,m) = secondsToHoursMinutes(seconds: Int(duration))
                    // Replace line below with this for hour to minutes: cell.rightLabel.text = "\(h)hrs \(m)min"
                    cell.rightLabel.text = "\(duration)"
                }
            }
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
