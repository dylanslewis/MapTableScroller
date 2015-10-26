//
//  MainViewController.swift
//  MapTableScroller
//
//  Created by Dylan Lewis on 26/10/2015.
//  Copyright © 2015 Dylan Lewis. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, MapTableScrollerDelegate {
    
    var mapTableScroller = MapTableScroller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.mapTableScroller.view)
        self.addChildViewController(self.mapTableScroller)
    }

    override func viewDidLayoutSubviews() {
        self.mapTableScroller.view.frame = self.view.bounds
    }
    
    // MARK: MapTableScrollerDelegate
    func didTapTableView() {
        
    }
    
    func didTapMapView() {
        
    }
    
}