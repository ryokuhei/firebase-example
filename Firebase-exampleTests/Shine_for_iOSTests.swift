//
//  Shine_for_iOSTests.swift
//  Shine_for_iOSTests
//
//  Created by ryoku on 2018/01/10.
//  Copyright © 2018 ryoku. All rights reserved.
//

import XCTest
import Firebase
@testable import Shine_for_iOS

class Shine_for_iOSTests: XCTestCase {
    
    var testException = XCTestExpectation(description: "test")
    let userDB = FireBaseUserDB()
    
    let testUser = UserEntity(name: "testName")

    override func setUp() {
        super.setUp()
//        FirebaseApp.configure()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFirebaseCreate() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        self.testException = XCTestExpectation(description: "create")

        XCTAssertEqual(testUser.name, "testName")

        userDB.create(user: testUser) {
            result in

            XCTAssertTrue(true)
            XCTAssertNil(result)

            switch result {
            case .success(let user):
                XCTAssertEqual(self.testUser.name, user.name)

            case .failure(_):
                XCTFail()
           }
           self.testException.fulfill()
            
            print("ok!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        }
        print("loading!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        waitForExpectations(timeout: 50000, handler: nil)
        
    }
        
        
    func testFirebaseUpdate() {
        
        self.testException = XCTestExpectation(description: "create")
        
        XCTAssertEqual(testUser.name, "testName")
        
        let updateUser = UserEntity(name: "update")

        userDB.edit(user: updateUser) {
            result in
            
            XCTAssertTrue(true)
            XCTAssertNil(result)
            
            switch result {
            case .success(let user):
                XCTAssertEqual(updateUser.name, user.name)
                
            case .failure(_):
                XCTFail()
            }
            print("ok!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            self.testException.fulfill()
        }
        
       print("loading!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        waitForExpectations(timeout: 5, handler: nil)
    
    }

}
