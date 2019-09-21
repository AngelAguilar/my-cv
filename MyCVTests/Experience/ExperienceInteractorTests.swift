//
//  ExperienceInteractorTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/18/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class ExperienceInteractorTests: XCTestCase {
    
    var interactor: ExperienceInteractor!
    let networkSession = NetworkSessionMock()
    var networkManager: NetworkManager!
    var output: ExperienceInteractorOutputMock!
    let jsonExperience = "[{\r\n      \"company\": \"Anzen Digital, Mexico City, Mexico\",\r\n      \"date\": \"Jul. 2017 - 2013 Present\",\r\n      \"title\": \"Lead Mobile Developer (iOS/Android).\",\r\n      \"description\": \"Developing Scotiabank Mexico App (iOS) from scratch, using TDD, code best practices and a CLEAN architecture.\"\r\n    }\r\n  ]"
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupExperienceInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    func setupExperienceInteractor() {
        interactor = ExperienceInteractor()
        output = ExperienceInteractorOutputMock()
        networkManager = NetworkManager(session: networkSession)
        interactor.networkManager = networkManager
        interactor.output = output
    }
    
    
    func testExperienceInteractorGetExperienceDataSuccess() {
        let expectationExperience = expectation(description: "Load experience expectation")
        networkSession.data = jsonExperience.data(using: .utf8)
        output.expectationExperience = expectationExperience
        interactor.getExperience()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    func testExperienceInteractorGetProfileImageDataError() {
        let expectationError = expectation(description: "Error data expectation")
        networkSession.error = NSError(domain: "", code: -1, userInfo: [:]) as Error
        output.expectationError = expectationError
        interactor.getExperience()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}

class ExperienceInteractorOutputMock: ExperienceInteractorOutput {
    var expectationExperience: XCTestExpectation?
    var expectationProfileData: XCTestExpectation?
    var expectationError: XCTestExpectation?
    
    func getExperienceSuccess(experience: [Job]) {
        expectationExperience?.fulfill()
    }
    
    func getExperienceError(error: String) {
        expectationError?.fulfill()
    }
    
}

