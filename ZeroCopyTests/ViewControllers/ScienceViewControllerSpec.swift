//
//  ScienceViewControllerSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 28/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble
import SafariServices

@testable import ZeroCopy

class ScienceViewControllerSpec: QuickSpec {
    
    override func spec() {
    
        var subject: ScienceViewController!
        var mockNavController: MockNavigationController!
        
        describe("ScienceViewController") {

            beforeEach {
                subject = ScienceViewController()
                mockNavController = MockNavigationController(rootViewController: UIViewController())
                mockNavController.pushViewController(subject, animated: false)
                subject.viewDidLoad()
            }
            
            context("when Setting View Controller is created and view did load") {
                it("it is configured") {
                    expect(subject).toNot(beNil())
                    expect(subject.tableView).toNot(beNil())
                    expect(subject.transitionManager).toNot(beNil())
                    expect(subject.tableView.dataSource).to(be(subject))
                    expect(subject.tableView.delegate).to(be(subject))
                    expect(subject.tableView.numberOfRows(inSection: 0)).to(equal(3))
                    expect(subject.tableView.cellForRow(at: IndexPath(row: 0, section: 0))).to(beAKindOf(UITableViewCell.self))
                    expect(subject.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryType).to(equal(.disclosureIndicator))
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
            
            context("when cell is pressed") {
                
                beforeEach {
                    subject.tableView.delegate?.tableView!(subject.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    subject.tableView.delegate?.tableView!(subject.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
                    subject.tableView.delegate?.tableView!(subject.tableView, didSelectRowAt: IndexPath(row: 2, section: 0))
                }
                
                it("view is no longer first responder") {
                    expect(subject.view.isFirstResponder).to(beFalse())
                }
            }
        }
    }
}
