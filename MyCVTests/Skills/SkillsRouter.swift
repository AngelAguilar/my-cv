//
//  SkillsRouter.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/19/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class SkillsRouterTests: XCTestCase {
    
    var viewController: SkillsViewController!
    var router: SkillsRouter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        router = SkillsRouter()
        super.setUp()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testAssembleSkillsRouter() {
        let viewController = router.assembleModule() as? SkillsViewController
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.presenter)
        XCTAssertNotNil(viewController?.presenter?.interactor)
        XCTAssertNotNil(viewController?.presenter?.router)
        XCTAssertNotNil(viewController?.presenter?.interactor?.networkManager)
        XCTAssertNotNil(viewController?.presenter?.view)
        XCTAssertNotNil(viewController?.presenter?.interactor?.output)
    }
}
