//
//  UserInput.swift
//  CountOnMe
//
//  Created by Dee Dee on 14/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class UserInput {
    var calculText: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: .updateTextMessage, object: nil, userInfo: ["updateMessage": calculText])
        }
    }
    private var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    }
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷" && elements.last != "="
    }
    // Expression Have Enough Element
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    // Identifying the second to last element
    var secondToLastIsEqual: Bool {
   return elements.count > 2 && elements[elements.count - 2] == "="
    }
    // Check if a completed operation is already displayed
    private var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }
    // clearing the display
    func clearDisplay() {
        calculText = ""
    }
    // Action when a number is pressed
    func numberButtonTapped(buttonTitle: String) {
        if secondToLastIsEqual || elements.last == "=" {
            clearDisplay()
        }
        if buttonTitle == "0" && elements.last == "÷" {
            sendAlertMessage(message: "Vous ne pouvez pas diviser par 0 !")
        } else {
            calculText.append(buttonTitle)
        }
    }
    // Action when an operator is pressed
    func tappedOperationButtons(operatorString: String ) {
        if expressionIsCorrect {
            if secondToLastIsEqual {
                lastResultText()
            }
            calculText.append(" \(operatorString) ")
        } else {
            sendAlertMessage(message: "Un operateur est déja mis !")
        }
    }
    func TappedPointButton() {
            if expressionIsCorrect && elements.last?.firstIndex(of: ".") == nil {
                if elements.isEmpty {
                    calculText.append("0")
                }
                calculText.append(".")
            }
        }
    // Action when AC button is pressed
    func tappedAc() {
        clearDisplay()
    }
    private func lastResultText() {
            let lastResult = elements.last!
            clearDisplay()
            calculText.append("\(lastResult)")
        }
    // Sending alert notification
    private func sendAlertMessage(message: String) {
        NotificationCenter.default.post(name: .alertMessage, object: nil, userInfo: ["message": message])
    }
    // Action when equal button is pressed
    func tappedEqualButton() {
        guard expressionIsCorrect else {
            return sendAlertMessage(message: "Entrez une expression correcte !")
        }
        guard expressionHaveEnoughElement else {
            return sendAlertMessage(message: "Démarrez un nouveau calcul !")
        }
        var operationsToReduce = elements
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            guard let left = Double(operationsToReduce[0]) else {return }
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else {return}
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        calculText.append(" = \(operationsToReduce.first!)")
    }
}
