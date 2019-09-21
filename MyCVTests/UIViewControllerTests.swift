//
//  UIViewControllerTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest

@testable import MyCV

class UIViewControllerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowLoading() {
        let viewController = UIViewController()
        let _ = viewController.view
        viewController.showLoader()
    }
    
    func testHideLoading() {
        let viewController = UIViewController()
        let _ = viewController.view
        viewController.showLoader()
        viewController.hideLoader()
    }

    func testShowError() {
        let viewController = UIViewController()
        let _ = viewController.view
        viewController.showAlertError("Mock error")
    }
    
}
