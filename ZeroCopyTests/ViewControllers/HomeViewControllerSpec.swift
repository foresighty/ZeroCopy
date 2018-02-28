//
//  HomeViewControllerSpec.swift
//  ZeroCopyTests
//
//  Created by Mike Gopsill on 15/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Quick
import Nimble
import UIKit

@testable import ZeroCopy

class HomeViewControllerSpec: QuickSpec {
    override func spec() {
        
        var subject: HomeViewController!
        var mockNavigationController: MockNavigationController!
        
        beforeEach {
            subject = HomeViewController()
            mockNavigationController = MockNavigationController(rootViewController: subject)
            subject.viewDidLoad()
        }
        
        context("when view did load") {
            
            it("should setup the TableView") {
                expect(subject.tableView).toNot(beNil())
                expect(subject.view.subviews).to(contain(subject.tableView))
            }
            it("should setup the HeaderView") {
                expect(subject.homeHeaderView).toNot(beNil())
                expect(subject.view.subviews).to(contain(subject.homeHeaderView))
            }
            it("should setup the Constraints") {
                expect(subject.view.constraints).toNot(beNil())
            }
        }
        
        context("when view did appear") {
            
            var color: UIColor!
            
            beforeEach {
                subject.viewDidAppear(true)
                if let titleTextAttributes = subject.navigationController?.navigationBar.titleTextAttributes {
                    color = titleTextAttributes[NSAttributedStringKey.foregroundColor] as! UIColor
                }
            }
            
            it("should set statusBarStyle to light content") {
                expect(UIApplication.shared.statusBarStyle).to(equal(UIStatusBarStyle.lightContent))
            }
            
            it("the navigation bar should be configured") {
                expect(subject.navigationController?.navigationBar.topItem?.title).to(equal("Zero"))
                expect(color).to(equal(UIColor.white))
                expect(subject.navigationController?.navigationBar.shadowImage).toNot(beNil())
                expect(subject.navigationController?.navigationBar.isTranslucent).to(equal(true))
                expect(subject.navigationItem.leftBarButtonItem?.title).to(equal("Settings"))
                expect(subject.navigationItem.rightBarButtonItem?.title).to(equal("Science"))
                expect(subject.navigationItem.leftBarButtonItem?.action).toNot(beNil())
                expect(subject.navigationItem.rightBarButtonItem?.action).toNot(beNil())
            }
        }
        
        context("when view disappears") {
            
            var shadowImage: UIImage?
            
            beforeEach {
                subject.viewDidDisappear(false)
                shadowImage = subject.navigationController?.navigationBar.shadowImage
            }
            
            it("should reconfigure the navigation bar shadow image") {
                expect(shadowImage).to(beNil())
            }
            
            it("should reset the default status bar style") {
                expect(UIApplication.shared.statusBarStyle).to(equal(UIStatusBarStyle.default))
            }
        }
        
        context("when settings button is pressed") {

            beforeEach {
                subject.settingsPressed()
            }
            
            it("should display a settings view controller") {
                expect(mockNavigationController.pushedViewController).toNot(beNil())
                expect(mockNavigationController.isSettingsViewController).to(beTrue())
            }
        }
        
        context("when settings button is pressed") {
            
            beforeEach {
                subject.sciencePressed()
            }
            
            it("should display a settings view controller") {
                expect(mockNavigationController.pushedViewController).toNot(beNil())
                expect(mockNavigationController.isScienceViewController).to(beTrue())
            }
        }
        
        context("when present method is called") {
            
            var saveFastViewController: SaveFastViewController!
            
            beforeEach {
                saveFastViewController = SaveFastViewController(startDate: Date(), endDate: Date())
                subject.present(saveFastViewController)
            }
            
            it("should present the passed in saveFastViewController") {
                expect(mockNavigationController.pushedViewController).toNot(beNil())
                expect(mockNavigationController.pushedViewController).to(be(saveFastViewController))
                expect(mockNavigationController.isSaveFastViewController).to(beTrue())
            }
        }
    }
}


class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    var isSettingsViewController = false
    var isScienceViewController = false
    var isSaveFastViewController = false
    var poppedViewController = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        if viewController is SettingViewController {
            isSettingsViewController = true
        }
        if viewController is ScienceViewController {
            isScienceViewController = true
        }
        if viewController is SaveFastViewController {
            isSaveFastViewController = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        poppedViewController = true
        super.popViewController(animated: animated)
        return nil
    }
}
