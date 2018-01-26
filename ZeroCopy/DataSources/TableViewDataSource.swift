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
        return 30
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return StartStopCell()
        }
        
        let label = UILabel(frame: CGRect(x: 30.0, y: 10.0, width: 100.0, height: 20.0))
        label.text = String(indexPath.row)
        let cell = UITableViewCell()
        cell.addSubview(label)
        return cell
    }
}
