//
//  ExperienceViewControllerTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/18/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class ExperienceViewControllerTests: XCTestCase {
    
    var viewController: ExperienceViewController!
    var presenter: ExperiencePresenterMock!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupExperienceViewController()
    }
    
    override func tearDown() {
        window = nil
        viewController = nil
        super.tearDown()
    }
    
    func setupExperienceViewController() {
        viewController = ExperienceViewController()
        presenter = ExperiencePresenterMock()
        viewController.presenter = presenter
        let _ = viewController.view
        viewController.beginAppearanceTransition(true, animated: false)
    }
    
    func testViewControllerSetup() {
        XCTAssertNotNil(viewController)
    }
    
    func testLoadExperience() {
        let jobs = [Job(company: "Company 1", title: "Software Engineer", date: "2010-2011", description: "Lead Software Engineer")]
        viewController.loadTableViewExperience(with: jobs)
        XCTAssertEqual(viewController.tableViewExperience.numberOfRows(inSection: 0), jobs.count)
    }
    
    func testViewDidAppear() {
        viewController.viewDidAppear(true)
        XCTAssertTrue(presenter.viewDidAppearCalled)
    }
    
}

class ExperiencePresenterMock: ExperiencePresentation {
    
    var view: ExperienceView?
    var interactor: ExperienceUseCase?
    var router: ExperienceWireframe?
    
    var viewDidAppearCalled = false
    
    func viewDidAppear() {
        viewDidAppearCalled = true
    }
    
}
