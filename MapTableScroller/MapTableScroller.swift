//
//  MapTableScroller.swift
//  MapTableScroller
//
//  Created by Dylan Lewis on 25/10/2015.
//  Copyright © 2015 Dylan Lewis. All rights reserved.
//

import Foundation
import UIKit
import MapKit

enum CurrentState {
    case TableVisible
    case TableHidden
}

protocol MapTableScrollerDelegate {
    func didTapMapView()
    func didTapTableView()
}

class MapTableScroller: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var currentState = CurrentState.TableVisible
    
    var delegate: MapTableScrollerDelegate?
    
    var mapView = MKMapView()
    var tableView: UITableView!
    var tableHeaderView = UIView()
    
    var mapTapRecogniser: UITapGestureRecognizer!
    var tableTapRecogniser: UITapGestureRecognizer!
    
    var collapsedTableViewHeaderHeight: CGFloat = 10
    var expandedTableViewHeaderHeight: CGFloat = 200
    var collapsedTableViewBottomOffset: CGFloat = 100
    var hideTableViewThreshold: CGFloat = -30
    var minimumMapHeight: CGFloat = 20
    
    var parallaxEnabled = true
    
    private var shouldDisplayMap = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.setupGestureRecognisers()
    }
    
    override func viewWillLayoutSubviews() {
        self.layout()
    }
    
    private func setupViews() {
        self.setupMapView()
        self.setupTableView()
        
        self.customise()
        self.layout()
    }
    
    private func setupGestureRecognisers() {
        self.tableTapRecogniser = UITapGestureRecognizer(target: self, action: "didTapGestureRecogniser:")
        self.mapTapRecogniser = UITapGestureRecognizer(target: self, action: "didTapGestureRecogniser:")
        
        self.tableTapRecogniser.delegate = self
        self.mapTapRecogniser.delegate = self
        
        self.tableView.addGestureRecognizer(self.tableTapRecogniser)
        self.tableView.tableHeaderView!.addGestureRecognizer(self.mapTapRecogniser)
    }


    //MARK: Button Handling
    func didTapGestureRecogniser(gesture: UITapGestureRecognizer) {
        switch self.currentState {
        case .TableVisible:
            self.makeTableHidden()
        case .TableHidden:
            self.makeTableVisible()
        }
    }
    
    func makeTableHidden() {
        if (self.delegate != nil) {
            self.delegate!.didTapMapView()
        }
        
        self.tableHeaderView.removeGestureRecognizer(self.mapTapRecogniser)

        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.tableHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.collapsedTableViewHeaderHeight)
            self.tableView.tableHeaderView = self.tableHeaderView

            self.tableView.frame.origin.y = self.view.bounds.height - self.collapsedTableViewBottomOffset
            }) { (complete) -> Void in
                self.currentState = .TableHidden
                
                self.tableView.allowsSelection = false
                self.tableView.scrollEnabled = false
        }
    }
    
    func makeTableVisible() {
        if (self.delegate != nil) {
            self.delegate!.didTapTableView()
        }
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.tableHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.expandedTableViewHeaderHeight)
            self.tableView.tableHeaderView = self.tableHeaderView

            self.tableView.frame = CGRect(x: 0, y: self.minimumMapHeight, width: self.view.bounds.width, height: self.view.bounds.height - self.minimumMapHeight)
            }) { (complete) -> Void in
                self.tableView.tableHeaderView = self.tableHeaderView
                
                self.currentState = .TableVisible
                
                self.tableView.tableHeaderView?.addGestureRecognizer(self.mapTapRecogniser)
                
                self.tableView.allowsSelection = true
                self.tableView.scrollEnabled = true
        }
    }

    
    //MARK: Scroll View Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (self.tableView.contentOffset.y < self.hideTableViewThreshold) {
            if (self.shouldDisplayMap == false) {
                self.shouldDisplayMap = true
            }
        } else {
            if (self.shouldDisplayMap == true) {
                self.shouldDisplayMap = false
            }
        }
        
        
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (self.shouldDisplayMap == true) {
            self.makeTableHidden()
        }
    }
    
    //MARK: Gesture Recogniser Deleagte
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer == self.tableTapRecogniser {
            if self.currentState == .TableHidden {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
}

