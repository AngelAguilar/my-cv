//
//  SkillsViewControllerTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class SkillsViewControllerTests: XCTestCase {
    
    var viewController: SkillsViewController!
    var presenter: SkillsPresenterMock!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        
        setupSkillsViewController()
    }
    
    override func tearDown() {
        window = nil
        viewController = nil
        super.tearDown()
    }
    
    func setupSkillsViewController() {
        viewController = SkillsViewController()
        presenter = SkillsPresenterMock()
        viewController.presenter = presenter
        let _ = viewController.view
    }

    func testViewControllerSetup() {
        XCTAssertNotNil(viewController)
    }
    
    func testLoadSkills() {
        let skills = [Skill(name: "Mock Skill 1", description: "Mock Skill description 1"),Skill(name: "Mock Skill 2", description: "Mock Skill description 2")]
        viewController.loadTableViewSkills(with: skills)
        XCTAssertEqual(viewController.tableViewSkills.numberOfRows(inSection: 0), skills.count)
    }
    
    func testViewDidAppear() {
        viewController.viewDidAppear(true)
        XCTAssertTrue(presenter.viewDidAppearCalled)
    }
    
}

class SkillsPresenterMock: SkillsPresentation {

    var view: SkillsView?
    var interactor: SkillsUseCase?
    var router: SkillsWireframe?

    var viewDidAppearCalled = false
    
    func viewDidAppear() {
        viewDidAppearCalled = true
    }
    
}
