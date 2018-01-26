//
//  TableViewDataSource.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 25/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
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
        
        if indexPath.row == 11 {
            let cell = ListCell()
            cell.updateDisplayForFooter()
            return cell
        }
        
        if indexPath.row == 12 {
            return WarningCell()
        }
        
        let cell = ListCell()
        cell.addButton()
        return cell
    
    }
}
