//
//  Model.swift
//  MVC
//
//  Created by Masaie on 06/7/22.
//

import Foundation

struct Model {
    
    var rpnResult = ""
    var displayWorking = ""
    
    private var currentWorking = ""
    private var expression = [String]()

    private var rpn: ReversPolishNotation!
    
    init() {
        rpn = ReversPolishNotation()
    }
    
    mutating func doAction() {
        expression.append(currentWorking)
        currentWorking = ""
        let result = rpn.calculate(expression)
        rpnResult = formatResult(result: result)
        expression = []
    }
    
    mutating func addToWorking(value: String) {
        let operators = "+-*/"
        
        if operators.contains(value) {
            expression.append(currentWorking)
            currentWorking = ""
            expression.append(value)
        } else {
            currentWorking = currentWorking + value
        }
        displayWorking = displayWorking + value
    }
    
    mutating func deleteLastSymbol() {
        if !displayWorking.isEmpty {
            displayWorking.removeLast()
        }
    }
    
    mutating func clearing() {
        currentWorking = ""
        displayWorking = ""
        expression = []
    }
    
    mutating func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
}
