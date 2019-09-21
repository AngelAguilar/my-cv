//
//  EncodeUtilsTests.swift
//  MyCVTests
//
//  Created by Angel Aguilar on 9/7/19.
//  Copyright © 2019 Angel Aguilar. All rights reserved.
//

import XCTest
@testable import MyCV

class EncodeUtilsTests: XCTestCase {
    
    let jsonString = "{\"name\":\"Angel Aguilar Aguilar\",\"summary\":\"Software Engineer with over 8 years of experience working in projects for Coca-Cola Industries as well as developing applications for banks such as Scotiabank, Banamex, Afirme, Invex and some other independent projects, mostly developing mobile technologies (Android, iOS and Hybrid Apps), using agile methodologies, new frameworks, and always looking to find the most elegant and efficient way of problem solving. Also, he enjoys getting involved throughout the complete process of any software project.\",\"title\":\"iOS Engineer\",\"email\":\"angel.aguilar.escom@gmail.com\",\"profile_image_url\":\"\"}"
    
    let incorrectJsonString = "{\"name\":\"Angel Aguilar Aguilar\",\"summary\":\"Software Engineer with over 8 years of experience working in projects for Coca-Cola Industries as well as developing applications for banks such as Scotiabank, Banamex, Afirme, Invex and some other independent projects, mostly developing mobile technologies (Android, iOS and Hybrid Apps), using agile methodologies, new frameworks, and always looking to find the most elegant and efficient way of problem solving. Also, he enjoys getting involved throughout the complete process of any software project.\",\"title\":\"iOS Engineer\",\"email\":\"angel.aguilar.escom@gmail.com\",\"profile_photo_url\":\"}"
    
    var encodeUtils: EncodeUtils!
    
    override func setUp() {
        encodeUtils = EncodeUtils()
    }
    
    override func tearDown() {
        encodeUtils = nil
    }
    
    func testGetObjectFromString() {
        let encodeUtils = EncodeUtils()
        do {
            let myProfileObject = try encodeUtils.get(Profile.self, from: jsonString)
            XCTAssertNotNil(myProfileObject)
        } catch (let error) {
            let errorDescription = error.localizedDescription
            XCTFail("Unable to get Object from String \(errorDescription)" )
        }
    }
    
    func testGetObjectFromDataString() {
        let encodeUtils = EncodeUtils()
        do {
            let jsonStringData = jsonString.data(using: .utf8)
            XCTAssertNotNil(jsonStringData)
            let myProfileObject = try encodeUtils.get(Profile.self, from: jsonStringData!)
            XCTAssertNotNil(myProfileObject)
        } catch (let error) {
            let errorDescription = error.localizedDescription
            XCTFail("Unable to get Object from String \(errorDescription)" )
        }
    }
    
    func testGetObjectFromIncorrectStringThrowsError() {
        let encodeUtils = EncodeUtils()
        do {
            let _ = try encodeUtils.get(Profile.self, from: incorrectJsonString)
            XCTFail("Should throw an error")
        } catch (let error) {
            let errorDescription = error.localizedDescription
            XCTAssertNotNil(error)
            XCTAssertNotNil(errorDescription)
        }
    }
    
    func testGetJSONFromObject() {
        let encodeUtils = EncodeUtils()
        do {
            let myProfileObject = try encodeUtils.get(Profile.self, from: jsonString)
            let myProfileJSONString = try encodeUtils.getJSONString(from: myProfileObject)
            XCTAssertNotNil(myProfileJSONString)
        } catch (let error) {
            let errorDescription = error.localizedDescription
            XCTFail("Unable to get Object from String \(errorDescription)" )
        }
    }
    
}
