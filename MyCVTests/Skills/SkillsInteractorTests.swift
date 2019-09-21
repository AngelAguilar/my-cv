//
//  SkillsInteractorTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class SkillsInteractorTests: XCTestCase {

    var interactor: SkillsInteractor!
    let networkSession = NetworkSessionMock()
    var networkManager: NetworkManager!
    var output: SkillsInteractorOutputMock!
    let jsonSkills = "[{\"name\":\"iOS\",\"description\":\"5 years\"},{\"name\":\"Java\",\"description\":\"2 years\"},{\"name\":\"JavaScript\",\"description\":\"1 Year\"},{\"name\":\"Objective C\",\"description\":\"1 year\"},{\"name\":\"Agile\",\"description\":\"3 years\"}]"
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupSkillsInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    func setupSkillsInteractor() {
        interactor = SkillsInteractor()
        output = SkillsInteractorOutputMock()
        networkManager = NetworkManager(session: networkSession)
        interactor.networkManager = networkManager
        interactor.output = output
    }
    
    
    func testSkillsInteractorGetSkillsDataSuccess() {
        let expectationSkills = expectation(description: "Load skills expectation")
        networkSession.data = jsonSkills.data(using: .utf8)
        output.expectationSkills = expectationSkills
        interactor.getSkills()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    func testSkillsInteractorGetProfileImageDataError() {
        let expectationError = expectation(description: "Error data expectation")
        networkSession.error = NSError(domain: "", code: -1, userInfo: [:]) as Error
        output.expectationError = expectationError
        interactor.getSkills()
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}

class SkillsInteractorOutputMock: SkillsInteractorOutput {

    var expectationSkills: XCTestExpectation?
    var expectationProfileData: XCTestExpectation?
    var expectationError: XCTestExpectation?
    
    func getSkillsSuccess(skills: [Skill]) {
        expectationSkills?.fulfill()
    }
    
    func getSkillsError(error: String) {
        expectationError?.fulfill()
    }
    
}
