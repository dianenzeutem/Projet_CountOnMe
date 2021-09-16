//
//  UserInput.swift
//  CountOnMe
//
//  Created by Dee Dee on 14/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class UserInput {
    
    var calculText : String = "1 + 1 = 2" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateMessage"), object: nil, userInfo: ["updateMessage": calculText])
        }
    }
    
    private var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    private var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }
    
    
    func numberButtonTapped(buttonTitle : String){
        if expressionHaveResult {
            calculText = ""
        }
        
        calculText.append(buttonTitle)
    }
    
    func tappedOperationButtons(operatorString : String ){
        if canAddOperator {
            calculText.append(" \(operatorString) ")
        } else {
            sendAlertMessage(message: "Un operateur est déja mis !")
        }
    }
    
    private func sendAlertMessage(message : String){
        let name = Notification.Name(rawValue: "alertMessage")
        let notification = Notification(name: name, object: nil, userInfo: ["message" : message])
        NotificationCenter.default.post(notification)
        
    }
    
    func tappedEqualButton(){
        guard expressionIsCorrect else {
            return sendAlertMessage(message: "Entrez une expression correcte !")
        }
        guard expressionHaveEnoughElement else {
            return sendAlertMessage(message: "Démarrez un nouveau calcul !")
        }
        
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
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
