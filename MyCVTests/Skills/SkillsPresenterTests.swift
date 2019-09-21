//
//  SkillsPresenterTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class SkillsPresenterTests: XCTestCase {
    
    var presenter: SkillsPresenter!
    var interactor: SkillsInteractorMock!
    var router: SkillsRouter!
    var view: SkillsViewMock!
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupSkillsPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupSkillsPresenter() {
        presenter = SkillsPresenter()
        
        interactor = SkillsInteractorMock()
        view = SkillsViewMock()
        router = SkillsRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
    }
    
    func testInteractorGetSkills() {
        presenter.viewDidAppear()
        XCTAssertTrue(interactor.getSkillsCalled)
    }
    
    func testViewSeSkillsData() {
        let expectationSkillsData = expectation(description: "Load skills data expectation")
        let skills = [Skill(name: "Mock Skill 1", description: "Mock Skill description 1"),Skill(name: "Mock Skill 2", description: "Mock Skill description 2")]
        view.expectationSkillsData = expectationSkillsData
        presenter.getSkillsSuccess(skills: skills)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testViewSkillsDataError() {
        let expectationError = expectation(description: "Load skills error expectation")
        view.expectationError = expectationError
        presenter.getSkillsError(error: "Mock Error")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

class SkillsViewMock: SkillsView {

    var loadedProfileData = false
    var loadedProfileImageData = false
    var expectationSkillsData: XCTestExpectation?
    var expectationError: XCTestExpectation?
    
    func loadSkills(_ skills: [Skill]) {
        expectationSkillsData?.fulfill()
    }
    
    func showError(_ error: String) {
        expectationError?.fulfill()
    }
    
}

class SkillsInteractorMock: SkillsUseCase {

    var networkManager: NetworkManager?
    
    var output: SkillsInteractorOutput?
    
    var getSkillsCalled = false
    
    func getSkills() {
        getSkillsCalled = true
    }
    
}
