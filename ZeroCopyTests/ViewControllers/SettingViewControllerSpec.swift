//
//  SettingViewControllerSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble

@testable import ZeroCopy

class SettingViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var subject: SettingViewController!
        var mockNavController: MockNavigationController!
        
        describe("SettingViewController") {
            
            beforeEach {
                subject = SettingViewController()
                mockNavController = MockNavigationController(rootViewController: UIViewController())
                mockNavController.pushViewController(subject, animated: false)
                subject.viewDidLoad()
            }
            
            context("when Setting View Controller is created and view did load") {
                it("it is configured") {
                    expect(subject).toNot(beNil())
                    expect(subject.tableView).toNot(beNil())
                    expect(subject.transitionManager).toNot(beNil())
                    expect(subject.bottomView).toNot(beNil())
                    expect(subject.tableView.dataSource).to(be(subject))
                    expect(subject.tableView.delegate).to(be(subject))
                    expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(12))
                    expect(subject.tableView.cellForRow(at: IndexPath(row: 0, section: 0))).to(beAKindOf(UITableViewCell.self))
                    expect(subject.tableView.cellForRow(at: IndexPath(row: 2, section: 0))).to(beAKindOf(ClearCell.self))
                }
            }
            
            context("when navigation bar done button pressed") {
                
                beforeEach {
                    subject.donePressed()
                }
                
                it("should pop the view controller") {
                    expect(mockNavController.poppedViewController).to(beTrue())
                }
            }
            
            context("when erase all data button is pressed") {
                
                beforeEach {
                    subject.tableView.selectRow(at: IndexPath(row: 4, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.middle)
                }
                
                it("presents an alert") {
                    expect(subject.view.isFirstResponder).to(beFalse())
                }
            }
            
        }
    }
}

