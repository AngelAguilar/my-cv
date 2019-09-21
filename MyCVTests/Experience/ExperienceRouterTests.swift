//
//  ExperienceRouterTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/19/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class ExperienceRouterTests: XCTestCase {
    
    var viewController: ExperienceViewController!
    var router: ExperienceRouter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        router = ExperienceRouter()
        super.setUp()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testAssembleExperienceRouter() {
        let viewController = router.assembleModule() as? ExperienceViewController
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.presenter)
        XCTAssertNotNil(viewController?.presenter?.interactor)
        XCTAssertNotNil(viewController?.presenter?.router)
        XCTAssertNotNil(viewController?.presenter?.interactor?.networkManager)
        XCTAssertNotNil(viewController?.presenter?.view)
        XCTAssertNotNil(viewController?.presenter?.interactor?.output)
    }
}
