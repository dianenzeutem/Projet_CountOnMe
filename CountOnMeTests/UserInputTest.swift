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
    func testGivenTapped5dividedby2_WhenEqualisTapped_ThenResultIs2point5() {
        calcul.numberButtonTapped(buttonTitle: "5")
        calcul.tappedOperationButtons(operatorString: "÷")
        calcul.numberButtonTapped(buttonTitle: "2")
        calcul.tappedEqualButton()
        XCTAssertEqual(calcul.calculText, "5 ÷ 2 = 2.5")
    }
    func testGivenDisplayIs1plus2equal3_WhenAcIsTapped_ThenScreenIsEmpty() {
        calcul.calculText = "1 + 2 = 3"
        calcul.tappedAc()
        XCTAssertEqual(calcul.calculText, "")
    }
    func testGivenPointButtonAnd1When_ThenResult0Coma1() {
        calcul.tappedAc()
        calcul.TappedPointButton()
        calcul.numberButtonTapped(buttonTitle: "1")
           XCTAssertEqual(calcul.calculText, "0.1")
       }
    func testGivenresultIs7_WhenPressOperator_ThenCalculTextIs7() {
        calcul.numberButtonTapped(buttonTitle: "5")
        calcul.tappedOperationButtons(operatorString: "+")
        calcul.numberButtonTapped(buttonTitle: "2")
        calcul.tappedEqualButton()
        calcul.tappedOperationButtons(operatorString: "+")
        XCTAssertEqual(calcul.calculText, "7 + ")
    }

    func testGivenBigOperation_WhenTapedEqual_ThenResultIs1() {
            calcul.calculText = "5 + 6 ÷ 3 - 2 × 3"
        calcul.tappedEqualButton()
            XCTAssertEqual(calcul.calculText, "5 + 6 ÷ 3 - 2 × 3 = 1")
        }
    // test
    func testGivenBigOperation_WhenTapedEqual_ThenResultIs35dot25() {
            calcul.calculText = "8 × 2 + 5 × 4 - 3 ÷ 4"
        calcul.tappedEqualButton()
            XCTAssertEqual(calcul.calculText, "8 × 2 + 5 × 4 - 3 ÷ 4 = 35.25")
        }
    
}

