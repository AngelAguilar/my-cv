//
//  MyProfileViewControllerTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/8/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class MyProfileViewControllerTests: XCTestCase {
    
    var viewController: MyProfileViewController!
    var presenter: MyProfilePresenterMock!
    var window: UIWindow!
    let profile = Profile(name: "Angel Aguilar Aguilar",
                          summary: "8 years of experience",
                          title: "iOS Engineer",
                          email: "angel@gmail.com",
                          profile_image_url: "12")
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMyProfileViewController()
    }
    
    override func tearDown() {
        window = nil
        viewController = nil
        super.tearDown()
    }
    
    func setupMyProfileViewController() {
        viewController = MyProfileViewController()
        presenter = MyProfilePresenterMock()
        viewController.presenter = presenter
        let _ = viewController.view
    }

    func testViewControllerSetup() {
        XCTAssertNotNil(viewController)
    }
    
    func testLoadProfileData() {
        viewController.loadProfile(profile: profile)
        XCTAssertEqual(viewController.labelName.text, "Angel Aguilar Aguilar")
        XCTAssertEqual(viewController.labelSummary.text, "8 years of experience")
        XCTAssertEqual(viewController.labelTitle.text, "iOS Engineer")
        XCTAssertEqual(viewController.labelEmail.text, "angel@gmail.com")
    }
    
    func testLoadSectionsTable() {
        viewController.loadProfile(profile: profile)
        viewController.tableViewSections.reloadData()
        XCTAssertEqual(viewController.tableViewSections.numberOfRows(inSection: 0),viewController.sections.count)
    }
    
    func testTapSkills() {
        viewController.loadProfileData(profile)
        viewController.presenter?.didTapSkills()
        XCTAssertTrue(presenter.skillsTapped)
    }
}

class MyProfilePresenterMock: MyProfilePresentation {

    var view: MyProfileView?
    var interactor: MyProfileUseCase?
    var router: MyProfileWireframe?
    var skillsTapped = false
    
    func viewDidLoad() {
    }
    
    func didTapSkills() {
        skillsTapped = true
    }
    
    func didTapExperience() {
        
    }
    
    func getProfileImageData(from url: String) {
    }
    
}
