//
//  TableViewDataSource.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 25/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var fasts: [FastModel]!
    var tableLength: Int!
    
    override init() {
        super.init()
        fasts = loadDummyData()
        
        let nonFastsCells = 6
        let maximumFastsToDisplay = 7
        tableLength = fasts.count < maximumFastsToDisplay ? fasts.count + nonFastsCells : maximumFastsToDisplay + nonFastsCells
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLength
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
        
        if indexPath.row == tableLength - 2 {
            let cell = ListCell()
            cell.updateDisplayForFooter()
            cell.leftLabel.text = "Average"
            cell.rightLabel.text = "TBD"
            return cell
        }
        
        if indexPath.row == tableLength - 1 {
            return WarningCell()
        }
        
        
        let cell = ListCell()
        cell.addButton()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        let dateStringForCell = formatter.string(from: fasts[indexPath.row-4].startTime!)
        cell.leftLabel.text = dateStringForCell
        let duration = fasts[indexPath.row-4].endTime!.timeIntervalSince(fasts[indexPath.row-4].startTime!)
        let (h,m) = secondsToHoursMinutes(seconds: Int(duration))
        cell.rightLabel.text = "\(h)hrs \(m)min"
        return cell
        
    }
    
    
    private func loadDummyData() -> [FastModel] {
        let jsonString = """
            {
                "fasts": [{
                        "startTime": "2018-01-29 08:56:50 +0000",
                        "endTime": "2018-01-29 22:36:50 +0000"
                    },
                    {
                        "startTime": "2018-01-30 08:56:50 +0000",
                        "endTime": "2018-01-30 20:52:50 +0000"
                    },
                    {
                        "startTime": "2018-01-31 08:56:50 +0000",
                        "endTime": "2018-01-31 21:56:50 +0000"
                    },
                    {
                        "startTime": "2018-02-01 08:56:50 +0000",
                        "endTime": "2018-02-01 22:30:20 +0000"
                    },
                    {
                        "startTime": "2018-02-02 08:56:50 +0000",
                        "endTime": "2018-02-02 22:11:50 +0000"
                    },
                    {
                        "startTime": "2018-02-03 08:56:50 +0000",
                        "endTime": "2018-02-03 18:26:50 +0000"
                    }]
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let fasts: Fasts = try! decoder.decode(Fasts.self, from: jsonData)
        return fasts.fasts
    }
    
    private func secondsToHoursMinutes(seconds : Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
    }
}
