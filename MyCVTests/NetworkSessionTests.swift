//
//  MyCVTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/7/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class NetworkSessionMock: NetworkSession {

    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?
    
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
    
}

class NetworkManagerTests: XCTestCase {

    let networkSession = NetworkSessionMock()
    var networkManager: NetworkManager?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkManager = NetworkManager(session: networkSession)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkSessionGetWithData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let data = Data()
        networkSession.data = data
        networkManager?.loadData(from: URL(fileURLWithPath: "")) {
            result in
                switch result {
                    case .success(let data) :
                        XCTAssertTrue(data == data)
                    case .failure(let error):
                        XCTFail("Should not get an error \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func testNetworkSessionGetWithDataAndURL() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let data = Data()
        networkSession.data = data
        networkSession.urlResponse = URLResponse(url: URL(fileURLWithPath: ""), mimeType: "", expectedContentLength: 200, textEncodingName: "")
        networkManager?.loadData(from: URL(fileURLWithPath: "")) {
            result in
            switch result {
            case .success(let data) :
                XCTAssertTrue(data == data)
            case .failure(let error):
                XCTFail("Should not get an error \(error?.localizedDescription ?? "")")
            }
        }
    }

    func testNetworkSessionGetWithError() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let error = NSError(domain: "Mock Error", code: -1, userInfo: [:]) as Error
        networkSession.error = error
        networkManager?.loadData(from: URL(fileURLWithPath: "")) {
            result in
            switch result {
            case .success(_) :
                XCTFail("Should get an error")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
}
