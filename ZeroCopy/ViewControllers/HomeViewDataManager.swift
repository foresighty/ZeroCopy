//
//  HomeViewDataManager.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 21/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//


import Foundation
import Presentables
import CoreData

protocol HomeViewDataManagerDelegate {
    func present(_ saveFastViewController: SaveFastViewController)
}

class HomeViewDataManager: PresentableTableViewDataManager, StartStopCellDelegate, ListCellDelegate, NSFetchedResultsControllerDelegate {
    
    private var listOfFasts: [Fast]
    private lazy var section = PresentableSection()
    private var delegate: HomeViewDataManagerDelegate!
    private var homeHeaderView: HomeHeaderView!
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    
    // MARK: Initialisation
    
    init(delegate: HomeViewDataManagerDelegate, homeHeaderView: HomeHeaderView) {
        guard let coreDataFasts = CoreDataManager.sharedInstance.retrieveFasts() else { fatalError("Core Data Error") }
        listOfFasts = coreDataFasts
        
        super.init()
        initializeFetchedResultsController()
        
        self.delegate = delegate
        self.homeHeaderView = homeHeaderView
        populateTable()
        NotificationCenter.default.addObserver(self, selector: #selector(appDidReopen), name:NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    
    // MARK: Table Setup
    
    private func populateTable() {
        createHeaderCells()
        createFastCells()
        createFooterCells()
        data.append(section)
    }

    private func createHeaderCells() {
        section.presentables.append(Presentable<StartStopCell>.create({ (cell) in
            cell.delegate = self
        }))
        section.presentables.append(Presentable<SevenDayTitleCell>.create())
        section.presentables.append(Presentable<GraphTableViewCell>.create())
        section.presentables.append(Presentable<HeaderListCell>.create())
    }
    
    private func createFastCells() {
        guard var fasts = fetchedResultsController.fetchedObjects else { return }
        
        if fasts.count > 7 {
            fasts.removeSubrange(7..<fasts.count)
        }
     
        for (index, fast) in fasts.enumerated() {
            section.presentables.append(Presentable<ListCell>.create({ (cell) in
                cell.updateDisplay(with: fast as! Fast)
                cell.delegate = self
                cell.index = index
            }))
        }
    }
    
    private func createFooterCells() {
        let footerListCellAverage = Presentable<FooterListCell>.create({ (cell) in
            cell.configForAverage(with: self.listOfFasts)
        })
        let footerListCellTotal = Presentable<FooterListCell>.create { (cell) in
            cell.configForTotal(with: self.listOfFasts)
        }

        section.presentables.append(footerListCellAverage)
        section.presentables.append(footerListCellTotal)
        section.presentables.append(Presentable<WarningCell>.create())
    }
    
    
    // MARK: CoreData Fetched Results Link Up
    
    private func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Fast")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Fast.startDate), ascending: false)]
        
        guard let moc = CoreDataManager.sharedInstance.managedContext else { return }
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    // MARK: CoreData Fetched Results Delegate Methods
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateTable(with: controller.fetchedObjects as! [Fast])
    }
    
    
    // MARK: Update Table Method
    
    private func updateTable(with fasts: [Fast]) {
        data.removeAll()
        section.presentables.removeAll()
        listOfFasts = fasts
        populateTable()
    }
    
    
    // MARK: Start Stop Cell Delegate Methods
    
    func runTimer() {
        homeHeaderView.startTiming()
    }
    
    func presentSaveFastViewContoller(closure: @escaping () -> Void) {
        let (startDate, endDate) = homeHeaderView.fastTimer.getTimerDates()
        let saveFastViewController = SaveFastViewController(startDate: startDate, endDate: endDate)
        saveFastViewController.startDate = startDate
        saveFastViewController.endDate = endDate
        saveFastViewController.completeButtonPress = closure
        saveFastViewController.homeHeaderView = homeHeaderView
        delegate?.present(saveFastViewController)
    }
    
    
    // MARK: List Cell Delegate Methods
    
    func didTap(at index: Int) {
        let fast = listOfFasts[index]
        let saveFastViewController = SaveFastViewController(with: fast)
        delegate?.present(saveFastViewController)
    }
    
    
    // MARK: App State Methods
    
    @objc func appDidReopen() {
        if homeHeaderView.fastTimer.isRunning {
            let (startDate, _) = homeHeaderView.fastTimer.getTimerDates()
            let seconds = abs(Int(startDate.timeIntervalSinceNow))
            homeHeaderView.fastTimer.seconds = seconds
        }
    }
}
