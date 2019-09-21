//
//  MyProfileInteractorTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class MyProfileInteractorTests: XCTestCase {
    
    let jsonStringProfile = "{\"name\":\"Angel Aguilar Aguilar\",\"summary\":\"Software Engineer with over 8 years of experience working in projects for Coca-Cola Industries as well as developing applications for banks such as Scotiabank, Banamex, Afirme, Invex and some other independent projects, mostly developing mobile technologies (Android, iOS and Hybrid Apps), using agile methodologies, new frameworks, and always looking to find the most elegant and efficient way of problem solving. Also, he enjoys getting involved throughout the complete process of any software project.\",\"title\":\"iOS Engineer\",\"email\":\"angel.aguilar.escom@gmail.com\",\"profile_image_url\":\"\"}"
    
    var interactor: MyProfileInteractor!
    let networkSession = NetworkSessionMock()
    var networkManager: NetworkManager!
    var output: MyProfileInteractorOutputMock!
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupMyProfileInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
    }
    
    func setupMyProfileInteractor() {
        interactor = MyProfileInteractor()
        output = MyProfileInteractorOutputMock()
        interactor.output = output
        networkManager = NetworkManager(session: networkSession)
        interactor.networkManager = networkManager
    }
    
    
    func testMyProfileInteractorGetProfileImageDataSuccess() {
        let expectationImage = expectation(description: "Load image expectation")
        networkSession.data = Data()
        output.expectationImage = expectationImage
        interactor.getImage(from: "http://www.google.com")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testMyProfileInteractorGetProfileDataError() {
        let expectationError = expectation(description: "Error data expectation")
        networkSession.error = NSError(domain: "", code: -1, userInfo: [:]) as Error
        output.expectationError = expectationError
        interactor.getProfileData()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testMyProfileInteractorHandleResponse() {
        let expectationData = expectation(description: "Load profile data expectation")
        let jsonData = jsonStringProfile.data(using: .utf8)
        output.expectationProfileData = expectationData
        interactor.handleProfileData(jsonData ?? Data())
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testMyProfileInteractorHandleResponseError() {
        let expectationError = expectation(description: "Load profile data Error expectation")
        output.expectationError = expectationError
        interactor.handleProfileData(Data())
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

class MyProfileInteractorOutputMock: MyProfileInteractorOutput {
    
    var expectationImage: XCTestExpectation?
    var expectationProfileData: XCTestExpectation?
    var expectationError: XCTestExpectation?
    
    func getProfileDataSuccess(profile: Profile) {
        expectationProfileData?.fulfill()
    }
    
    func getProfileImageSuccess(imageData: Data) {
        expectationImage?.fulfill()
    }
    
    func getProfileDataError(error: String) {
        expectationError?.fulfill()
    }
    
    
}
