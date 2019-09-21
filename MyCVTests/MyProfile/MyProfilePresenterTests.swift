//
//  MyProfilePresenterTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class MyProfilePresenterTests: XCTestCase {
    
    var presenter: MyProfilePresenter!
    var interactor: MyProfileInteractorMock!
    var router: MyProfileRouterMock!
    var view: MyProfileViewMock!
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupMyProfilePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupMyProfilePresenter() {
        presenter = MyProfilePresenter()
        
        interactor = MyProfileInteractorMock()
        view = MyProfileViewMock()
        router = MyProfileRouterMock()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
    }
    
    func testInteractorGetData() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.profileDataCalled)
        presenter.getProfileImageData(from: "")
        XCTAssertTrue(interactor.getImageFromUrlCalled)
    }
    
    func testViewSetImageData() {
        let expectationImage = expectation(description: "Load image expectation")
        view.expectationImage = expectationImage
        presenter.getProfileImageSuccess(imageData: Data())
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testViewSetProfileData() {
        let expectationProfileData = expectation(description: "Load profile data expectation")
        let profile = Profile(name: "Angel Aguilar Aguilar",
                              summary: "8 years of experience",
                              title: "iOS Engineer",
                              email: "angel@gmail.com",
                              profile_image_url: "12")
        view.expectationProfileData = expectationProfileData
        presenter.getProfileDataSuccess(profile: profile)
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testViewProfileDataError() {
        let expectationError = expectation(description: "Load profile error expectation")
        view.expectationError = expectationError
        presenter.getProfileDataError(error: "Mock Error")
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testPresentSkills() {
        presenter.didTapSkills()
        XCTAssertTrue(router.presentSkillsCalled)
    }
    
    func testPresentExperience() {
        presenter.didTapExperience()
        XCTAssertTrue(router.presentExperienceCalled)
    }
}

class MyProfileViewMock: MyProfileView {

    var loadedProfileData = false
    var loadedProfileImageData = false
    var expectationImage: XCTestExpectation?
    var expectationProfileData: XCTestExpectation?
    var expectationError: XCTestExpectation?
    
    func loadProfileData(_ data: Profile) {
        expectationProfileData?.fulfill()
    }
    
    func loadProfileImageData(_ data: Data) {
        expectationImage?.fulfill()
    }
    
    func showError(_ error: String) {
        expectationError?.fulfill()
    }
     
}

class MyProfileInteractorMock: MyProfileUseCase {
    var networkManager: NetworkManager?
    
    var output: MyProfileInteractorOutput?
    
    var profileDataCalled = false
    var getImageFromUrlCalled = false
    
    func getProfileData() {
        profileDataCalled = true
    }
    
    func getImage(from url: String) {
        getImageFromUrlCalled = true
    }
}

class MyProfileRouterMock: MyProfileWireframe {
    
    var viewController: UIViewController?
    
    func assembleModule() -> UIViewController {
        return UIViewController()
    }
    
    var presentSkillsCalled = false
    var presentExperienceCalled = false
    
    func presentSkillsView() {
        presentSkillsCalled = true
    }
    
    func presentExperienceView() {
        presentExperienceCalled = true
    }
    
}
