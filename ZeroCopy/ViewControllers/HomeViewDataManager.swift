//
//  HomeViewDataManager.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 21/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//


import Foundation
import Presentables

class HomeViewDataManager: PresentableTableViewDataManager, CellDelegate {
    
    private var listOfFasts: [Fast]
    private lazy var section = PresentableSection()
    public var delegate: CellDelegate?
    
    // MARK: Initialisation
    
    init(with fasts: [Fast], delegate: CellDelegate) {
        self.listOfFasts = fasts
        self.delegate = delegate
        
        super.init()
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
        for (index, fast) in listOfFasts.enumerated() {
            section.presentables.append(Presentable<ListCell>.create({ (cell) in
                cell.updateDisplay(with: fast)
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
    
    
    // MARK: Public Methods
    
    public func updateTable(with fasts: [Fast]) {
        data.removeAll()
        section.presentables.removeAll()
        listOfFasts = fasts
        createHeaderCells()
        createFastCells()
        createFooterCells()
        data.append(section)
    }
    
    // MARK: Cell Delegate Methods:
    func runTimer() {
        delegate?.runTimer()
    }
    
    func presentSaveFastViewContoller(closure: @escaping () -> Void) {
        delegate?.presentSaveFastViewContoller(closure: closure)
    }
    
    func presentFastDetailViewControllerForFast(at index: Int) {
        delegate?.presentFastDetailViewControllerForFast(at: index)
    }
}
