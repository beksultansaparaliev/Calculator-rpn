//
//  Calculator.swift
//  MVC
//
//  Created by Masaie on 6/7/22.
//

import Foundation

struct Calculator {
    
    var working: String = ""
    var operationsResult: String = ""
    
    mutating func equalsPressed() {
        let checkedWorkingsForPercent = working.replacingOccurrences(of: "%", with: "*0.01")
        let expression = NSExpression(format: checkedWorkingsForPercent)
        let result = expression.expressionValue(with: nil, context: nil) as! Double
        operationsResult = formatResult(result: result)
    }
    
    mutating func validInput() -> Bool {
        var count = 0
        var workingStack = [Int]()
        
        for char in working {
            if specialCharacter(char: char) {
                workingStack.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in workingStack {
            if index == 0 {
                return false
            }
            
            if index == working.count - 1 {
                return false
            }
            
            if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
    
        return true
    }
    
    func specialCharacter (char: Character) -> Bool {
        if char == "*" {
            return true
        }
        if char == "/" {
            return true
        }
        if char == "+" {
            return true
        }
        return false
    }
    
    mutating func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    mutating func deletePressed() {
        if !working.isEmpty {
            working.removeLast()
        }
    }
    
    mutating func addToWorking(value: String) {
        working = working + value
    }
    
    mutating func clearCurrent() {
        working = ""
    }
}
