//
//  UserInputTest.swift
//  CountOnMeTests
//
//  Created by Dee Dee on 14/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe
class UserInputTest: XCTestCase {

    func testGivenInstanceOfUserInput_WhenAccessingIT_ThenItExists(){
        let userInput = UserInput()
    XCTAssertNotNil(userInput)
    }

}
