//
//  MyProfileRouterTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/19/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class MyProfileRouterTests: XCTestCase {
    
    var viewController: MyProfileViewController!
    var router: MyProfileRouter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        router = MyProfileRouter()
        super.setUp()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testAssembleMyProfileRouter() {
        let viewController = (router.assembleModule() as? UINavigationController)?.visibleViewController as? MyProfileViewController
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.presenter)
        XCTAssertNotNil(viewController?.presenter?.interactor)
        XCTAssertNotNil(viewController?.presenter?.router)
        XCTAssertNotNil(viewController?.presenter?.interactor?.networkManager)
        XCTAssertNotNil(viewController?.presenter?.view)
        XCTAssertNotNil(viewController?.presenter?.interactor?.output)
    }
}
