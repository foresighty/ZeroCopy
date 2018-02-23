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

class HomeViewDataManager: PresentableTableViewDataManager, CellDelegate, NSFetchedResultsControllerDelegate {
    
    private var listOfFasts: [Fast]
    private lazy var section = PresentableSection()
    public var delegate: CellDelegate?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    
    // MARK: Initialisation
    
    init(delegate: CellDelegate) {
        guard let coreDataFasts = CoreDataManager.sharedInstance.retrieveFasts() else { fatalError("Core Data Error") }
        listOfFasts = coreDataFasts
        super.init()
        initializeFetchedResultsController()
        self.delegate = delegate
        populateTable()
    }
    
    
    // MARK: Table Setup
    
    private func populateTable() {
        createHeaderCells()
        createFastCells()
        createFooterCells()
        data.append(section)
    }

    private func createHeaderCells() {
        section.presentables.append(Presentable<StartStopCell>.create())
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
            }).cellSelected {
                print("selected")
            })
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
    
    
    // MARK: CoreData Link Up
    
    func initializeFetchedResultsController() {
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
    
    
    // MARK: Public Methods
    
    public func updateTable(with fasts: [Fast]) {
        data.removeAll()
        section.presentables.removeAll()
        listOfFasts = fasts
        populateTable()
    }
    
    
    // MARK: Cell Delegate Methods
    
    func runTimer() {
        delegate?.runTimer()
    }
    
    func presentSaveFastViewContoller(closure: @escaping () -> Void) {
        delegate?.presentSaveFastViewContoller(closure: closure)
    }
    
    func presentFastDetailViewControllerForFast(at index: Int) {
        delegate?.presentFastDetailViewControllerForFast(at: index)
    }
    
    
    // MARK: Delegate Methods
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateTable(with: controller.fetchedObjects as! [Fast])
    }
}
