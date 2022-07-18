//
//  ReversePolishNotation.swift
//  MVC
//
//  Created by Masaie on 14/7/22.
//

import Foundation

struct ReversPolishNotation {
    
    func calculate(_ expression: [String]) -> Double {
        let postfixExpression = getToPostfixExpression(expression)
        let result = rpnCalculate(postfixExpression)
        return result
    }
    
    private func getToPostfixExpression(_ expression: [String]) -> [String] {
        let priority = [
            "*": 3,
            "/": 3,
            "+": 2,
            "-": 2,
            "(": 1,
        ]
    
        var operationsStack = [String]()
        var postfixList = [String]()
        let tokenList = expression
        
        for token in tokenList {
            if let _ = Double(token) {
                postfixList.append(String(token))
                
//            } else if token == "(" {
//                operationsStack.append(String(token))
//
//            } else if token == ")" {
//                var topToken = operationsStack.popLast()
//
//                while topToken != "(" {
//                    postfixList.append(topToken ?? "")
//                    topToken = operationsStack.popLast()
//                }
            } else {
                while !operationsStack.isEmpty && priority[operationsStack.last ?? ""] ?? 0 >= priority[String(token)] ?? 0 {
                    postfixList.append(operationsStack.removeLast())
                }
                operationsStack.append(String(token))
            }
        }
        
        while !operationsStack.isEmpty {
            postfixList.append(operationsStack.removeLast())
        }
        return postfixList
    }
    
    private func rpnCalculate(_ postfixEspression: [String]) -> Double {
        var stack = [Double]()
        
        for token in postfixEspression {
            if let num = Double(token) {
                stack.append(num)
            } else {
                guard let postNum = stack.popLast(), let prevNum = stack.popLast() else {
                    fatalError("Ошибка")
                }
                
                stack.append(operate(token, prevNum, postNum))
            }
        }
        
        if let last = stack.last {
            return last
        } else {
            fatalError("Ошибка")
        }
    }
    
    private func operate(_ operand: String, _ firstOperator: Double, _ secondOperator: Double) -> Double {
        switch operand {
        case "+":
            return firstOperator + secondOperator
        case "-":
            return firstOperator - secondOperator
        case "*":
            return firstOperator * secondOperator
        case "/":
            return firstOperator / secondOperator
        default:
            fatalError("Ошибка")
        }
    }
}
