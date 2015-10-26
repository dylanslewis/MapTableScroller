//
//  MapTableSccroller-Table.swift
//  MapTableScroller
//
//  Created by Dylan Lewis on 25/10/2015.
//  Copyright © 2015 Dylan Lewis. All rights reserved.
//

import Foundation
import UIKit

extension MapTableScroller {
    
    func setupTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: self.minimumMapHeight, width: self.view.bounds.width, height: self.view.bounds.height - self.minimumMapHeight), style: UITableViewStyle.Plain)
        self.tableView.tableHeaderView = self.tableHeaderView

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TopCell")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "OtherCell")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "BottomCell")
        
        self.view.addSubview(self.tableView)
    }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if (indexPath.row == 0) {
            cell = self.tableView.dequeueReusableCellWithIdentifier("TopCell")!

            let shadowPath = UIBezierPath(rect: CGRect(x: cell.layer.bounds.origin.x, y: cell.layer.bounds.origin.y, width: self.tableView.bounds.width, height: 10)).CGPath
            cell.layer.shadowPath = shadowPath
            cell.layer.shadowOffset = CGSize(width: -2, height: -2)
            cell.layer.shadowColor = UIColor.grayColor().CGColor
            cell.layer.shadowOpacity = 0.75

            cell.backgroundColor = .whiteColor()
        } else if (indexPath.row == self.tableView.numberOfRowsInSection(indexPath.section)-1) {
            cell = self.tableView.dequeueReusableCellWithIdentifier("BottomCell")!
            
            let bottomView = UIView()
            bottomView.backgroundColor = .whiteColor()
            bottomView.frame = CGRect(x: 0, y: cell.layer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height)
            
            cell.addSubview(bottomView)
        } else {
            cell = self.tableView.dequeueReusableCellWithIdentifier("OtherCell")!

            
        }
        
        cell.textLabel?.text = "Hello World"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let totalRows = 20
        
        if (indexPath.row == totalRows-1) {
            let cellsHeight = CGFloat(totalRows) * cell.frame.size.height
            let tableHeight = tableView.frame.size.height - self.expandedTableViewHeaderHeight
            
            if ((cellsHeight - tableView.frame.origin.y) < tableHeight) {
                let footerHeight = tableHeight - cellsHeight
                tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: footerHeight))
                tableView.tableFooterView?.backgroundColor = .whiteColor()
            }
        }
    }
}