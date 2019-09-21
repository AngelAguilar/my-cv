//
//  ExperiencePresenterTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/18/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class ExperiencePresenterTests: XCTestCase {
    
    var presenter: ExperiencePresenter!
    var interactor: ExperienceInteractorMock!
    var router: ExperienceRouter!
    var view: ExperienceViewMock!
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupExperiencePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupExperiencePresenter() {
        presenter = ExperiencePresenter()
        
        interactor = ExperienceInteractorMock()
        view = ExperienceViewMock()
        router = ExperienceRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
    }
    
    func testInteractorGetExperience() {
        presenter.viewDidAppear()
        XCTAssertTrue(interactor.getExperienceCalled)
    }
    
    func testViewSeExperienceData() {
        let expectationExperienceData = expectation(description: "Load experience data expectation")
        let jobs = [Job(company: "Company 1", title: "Software Engineer", date: "2010-2011", description: "Lead Software Engineer")]
        view.expectationExperienceData = expectationExperienceData
        presenter.getExperienceSuccess(experience: jobs)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testViewExperienceDataError() {
        let expectationError = expectation(description: "Load experience error expectation")
        view.expectationError = expectationError
        presenter.getExperienceError(error: "Mock Error")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

class ExperienceViewMock: ExperienceView {
    
    var loadedProfileData = false
    var loadedProfileImageData = false
    var expectationExperienceData: XCTestExpectation?
    var expectationError: XCTestExpectation?
    
    func loadExperience(_ jobs: [Job]) {
        expectationExperienceData?.fulfill()
    }
    
    func showError(_ error: String) {
        expectationError?.fulfill()
    }
    
}

class ExperienceInteractorMock: ExperienceUseCase {
    
    var networkManager: NetworkManager?
    
    var output: ExperienceInteractorOutput?
    
    var getExperienceCalled = false
    
    func getExperience() {
        getExperienceCalled = true
    }
    
}
