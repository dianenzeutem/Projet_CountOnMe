//
//  UserInput.swift
//  CountOnMe
//
//  Created by Dee Dee on 14/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class UserInput {
    // variable containning the display text
    var calculText: String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: .updateTextMessage, object: nil, userInfo: ["updateMessage": calculText])
        }
    }
    
    // Transforms calculText into an array of Strings
    private var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    // MARK: - Error check
    
    // This boolean check that the text does not end with + or - or x or ÷ or =
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
    
    // Sending alert notification
    private func sendAlertMessage(message: String) {
        NotificationCenter.default.post(name: .alertMessage, object: nil, userInfo: ["message": message])
    }
    
    // MARK: - Buttons methods
    
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
        if expressionIsCorrect && !elements.isEmpty {
            if secondToLastIsEqual {
                lastResultText()
            }
            calculText.append(" \(operatorString) ")
        } else {
            sendAlertMessage(message: "Vous ne pouvez pas saisir d'opérateur !")
        }
    }
    
    func TappedPointButton() {
        if secondToLastIsEqual || elements.last == "=" {
            clearDisplay()
        }
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
    
    // Action when equal button is pressed
    func tappedEqualButton() {
        if expressionIsCorrect && expressionHaveEnoughElement && elements.firstIndex(of: "=") == nil && !elements.isEmpty {
            let result = makeCalcul()
            calculText.append(" = \(result)")
        } else {
            sendAlertMessage(message: "Impossible ! Erreur de synthaxe dans votre opération. Veuillez entrer un chiffre ou corriger avec la touche AC.")
        }
    }
    
    // clearing the display
    func clearDisplay() {
        calculText = ""
    }
    
    // This method takes the last element of elements and replaces all the text with this one
    private func lastResultText() {
        guard let lastResult = elements.last else {return}
        clearDisplay()
        calculText.append("\(lastResult)")
    }
    
    // MARK: - Calcul Methods
    
    // This method calculates the result of the operation
    func makeCalcul() -> String {
        var operationsToReduce = elements
        var priorityOperator: Bool {
            return (operationsToReduce.firstIndex(of: "×") != nil) || (operationsToReduce.firstIndex(of: "÷") != nil)
        }
        while operationsToReduce.count > 1 {
            while priorityOperator {
                if let indexTempOfOperator = operationsToReduce.firstIndex(where: {$0 == "×" || $0 == "÷"}) {
                    let operand = operationsToReduce[indexTempOfOperator]
                    if let leftNumber = Double(operationsToReduce[indexTempOfOperator - 1]) {
                        if let rightNumber = Double(operationsToReduce[indexTempOfOperator + 1]) {
                            var priorityOperationsResult: Double = 0.0
                            
                            if operand == "×" {
                                priorityOperationsResult = leftNumber * rightNumber
                            } else {
                                if rightNumber != 0 { priorityOperationsResult = leftNumber / rightNumber
                                } else {
                                    sendAlertMessage(message: "Impossible de diviser par 0")
                                    calculText.append("Erreur")
                                }
                            }
                            operationsToReduce[indexTempOfOperator - 1] = formatingText(currentResult: priorityOperationsResult)
                            operationsToReduce.remove(at: indexTempOfOperator + 1)
                            operationsToReduce.remove(at: indexTempOfOperator)
                        }
                        
                    }
                }
                
            }
            if operationsToReduce.count > 1 {
                if let left = Double(operationsToReduce[0]) {
                    let operand = operationsToReduce[1]
                    if let right = Double(operationsToReduce[2]) {
                        var result: Double = 0
                        if operand == "+" { result = left + right
                        }
                        if operand == "-" { result = left - right
                        }
                        operationsToReduce = Array(operationsToReduce.dropFirst(3))
                        operationsToReduce.insert("\(formatingText(currentResult: result))", at: 0)
                    }
                    
                }
                
            }
        }
        guard let operationToReturn = operationsToReduce.first else {return " " }
        return operationToReturn
        
    }
    // This function formats a Double into a String with or without the comma as required
    private func formatingText(currentResult: Double) -> String {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .decimal
        guard let numberAsString = numberFormater.string(from: NSNumber(value: currentResult)) else { return "ERROR" }
        return numberAsString
    }
}
