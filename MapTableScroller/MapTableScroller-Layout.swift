//
//  MapTableScroller-Layout.swift
//  MapTableScroller
//
//  Created by Dylan Lewis on 25/10/2015.
//  Copyright © 2015 Dylan Lewis. All rights reserved.
//

import Foundation
import UIKit

extension MapTableScroller {
    
    func layout() {
        self.mapView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - self.collapsedTableViewBottomOffset)
        
        self.tableView.frame = CGRect(x: 0, y: self.minimumMapHeight, width: self.view.bounds.width, height: self.view.bounds.height - self.minimumMapHeight)
        self.tableHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.expandedTableViewHeaderHeight)

        self.tableView.tableHeaderView = self.tableHeaderView
    }
    
    func layoutForCurrentState() {
        switch self.currentState {
        case .TableHidden:
            self.layoutForTableHidden()
        case.TableVisible:
            self.layoutForTableVisible()
        }
    }
    
    func layoutForTableHidden() {
        
    }
    
    func layoutForTableVisible() {
    }
}