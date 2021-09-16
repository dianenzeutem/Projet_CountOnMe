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
    var calcul: UserInput!
    override func setUp() {
        super.setUp()
        calcul = UserInput()
    }
    func testGivenTapped4Plus5_WhenEqualisTapped_ThenResultIs9() {
        calcul.numberButtonTapped(buttonTitle: "4")
        calcul.tappedOperationButtons(operatorString: "+")
        calcul.numberButtonTapped(buttonTitle: "5")
        calcul.tappedEqualButton()
        XCTAssertEqual(calcul.calculText, "4 + 5 = 9")
    }
    func testGivenTapped10less9_WhenEqualisTapped_ThenResultIs1() {
        calcul.numberButtonTapped(buttonTitle: "10")
        calcul.tappedOperationButtons(operatorString: "-")
        calcul.numberButtonTapped(buttonTitle: "9")
        calcul.tappedEqualButton()
        XCTAssertEqual(calcul.calculText, "10 - 9 = 1")
    }
    func testGivenTapped6x2_WhenEqualisTapped_ThenResultIs12() {
        calcul.numberButtonTapped(buttonTitle: "6")
        calcul.tappedOperationButtons(operatorString: "×")
        calcul.numberButtonTapped(buttonTitle: "2")
        calcul.tappedEqualButton()
        XCTAssertEqual(calcul.calculText, "6 × 2 = 12")
    }
    func testGivenTapped3dividedby10_WhenEqualisTapped_ThenResultIs3() {
        calcul.numberButtonTapped(buttonTitle: "30")
        calcul.tappedOperationButtons(operatorString: "÷")
        calcul.numberButtonTapped(buttonTitle: "10")
        calcul.tappedEqualButton()
        XCTAssertEqual(calcul.calculText, "30 ÷ 10 = 3")
    }
    func testGivendisplayIs1plus2equal3_WhenAcIsTapped_ThenScreenIsEmpty() {
        calcul.calculText = "1 + 2 = 3"
        calcul.tappedAc()
        XCTAssertEqual(calcul.calculText, "")
    }
}
