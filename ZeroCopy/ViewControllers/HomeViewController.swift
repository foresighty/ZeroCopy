//
//  HomeViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 12/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit
import CoreData
import Presentables

class HomeViewController: UIViewController, CellDelegate {
    
    var homeHeaderView: HomeHeaderView!
    var tableView: UITableView!
    
    var transitionManager: TransitionManager = TransitionManager()
    var fastTimer: FastTimer = FastTimer()
    
    let constraintRangeForHeaderView = (CGFloat(-190)..<CGFloat(0))
    let constraintRangeForHeaderTransparency = (CGFloat(-130)..<CGFloat(-30))

    var defaultNavigationBarShadow: UIImage!
    
    var currentFast: Fast?
    var listOfFasts: [Fast]?
    
    var tableManager: PresentableManager?
    
    
    // MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupHeaderView()
        setupNavigationController()
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(appDidReopen), name:NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        styleNavigationController()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.shadowImage = nil
        UIApplication.shared.statusBarStyle = .default
    }
    
    
    // MARK: Setup
    
    private func setupNavigationController() {
        guard let navigationController = navigationController  else {
            fatalError("navigationController does not exist")
        }
        
        navigationController.navigationBar.topItem?.title = "Zero"
        let leftButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsPressed))
        let rightButton = UIBarButtonItem(title: "Science", style: .plain, target: self, action: #selector(sciencePressed))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func styleNavigationController() {
        guard let navigationController = navigationController  else {
            fatalError("navigationController does not exist")
        }

        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor  : UIColor.white]
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableManager = HomeViewDataManager(delegate: self)
    
        tableView.bind(withPresentableManager: &tableManager!)

        tableView.frame = view.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.delegate = self
        
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
    
    private func updateCoreData() {
        listOfFasts = CoreDataManager.sharedInstance.retrieveFasts()
    }
    
    // MARK: Button Methods
    
    @objc func settingsPressed() {
        let transition = transitionManager.transitionUp()
        navigationController!.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(SettingViewController(), animated: false)
    }
    
    @objc func sciencePressed() {
        let transition = transitionManager.transitionUp()
        navigationController!.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(ScienceViewController(), animated: false)
    }
    
    // MARK: App State Methods

    @objc func appDidReopen() {
        if fastTimer.isRunning {
            let (startDate, _) = fastTimer.getTimerDates()
            let seconds = abs(Int(startDate.timeIntervalSinceNow))
            homeHeaderView.updateTimerWith(newSeconds: seconds)
        }
    }
    
    // MARK: CellDelegate Methods
    
    func runTimer() {
        fastTimer.runTimer()
        homeHeaderView.startTiming()
    }
    
    func presentSaveFastViewContoller(closure: @escaping () -> Void) {
        let completeButtonPress = closure
        let (startDate, endDate) = fastTimer.getTimerDates()
        let saveFastViewController = SaveFastViewController(startDate: startDate, endDate: endDate) {
            self.stopTiming()
        }
        saveFastViewController.startDate = startDate
        saveFastViewController.endDate = endDate
        saveFastViewController.completeButtonPress = completeButtonPress
        
        let transition = transitionManager.transitionUp()
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(saveFastViewController, animated: false)
    }
    
    func presentFastDetailViewControllerForFast(at index: Int) {
        updateCoreData()
        guard let listOfFasts = listOfFasts else { return }
        let fast = listOfFasts[index]
        let startDate = fast.startDate!
        let endDate = fast.endDate!
        let saveFastViewController = SaveFastViewController(startDate: startDate, endDate: endDate, completion: nil)
        saveFastViewController.fast = fast
        
        let transition = transitionManager.transitionUp()
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(saveFastViewController, animated: false)
    }
    
    // Method
    
    func stopTiming() {
        fastTimer.stopTimer()
        homeHeaderView.stopTiming()
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
        if homeHeaderViewTopConstraint.constant < constraintRangeForHeaderView.upperBound && scrollView.contentOffset.y < 0 {
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
