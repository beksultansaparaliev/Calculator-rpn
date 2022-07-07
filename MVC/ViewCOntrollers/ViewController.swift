//
//  ViewControllerSecond.swift
//  MVC
//
//  Created by Masaie on 6/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var calculatorWorkings: UILabel!
    @IBOutlet var calculatorResults: UILabel!
    
    private var workings = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    
    //MARK: - IBActions
    @IBAction func allClearTap(_ sender: UIButton) {
        clearAll()
    }
   
    @IBAction func backTap(_ sender: UIButton) {
        if !workings.isEmpty {
            workings.removeLast()
            calculatorWorkings.text = workings
        }
    }
    
    @IBAction func equalsTap(_ sender: UIButton) {
        if validInput() {
            let checkWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*.01")
            let expression = NSExpression(format: checkWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResults.text = resultString
        } else {
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Calculator unable to do math based of input",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if sender.tag == 10 {
            addToWorkings(value: "%")
        } else if sender.tag == 11 {
            addToWorkings(value: "/")
        } else if sender.tag == 12 {
            addToWorkings(value: "*")
        } else if sender.tag == 13 {
            addToWorkings(value: "-")
        } else if sender.tag == 14 {
            addToWorkings(value: "+")
        } else if sender.tag == 15 {
            addToWorkings(value: ".")
        }
    }

    @IBAction func digits(_ sender: UIButton) {
        addToWorkings(value: String(sender.tag))
    }

    //MARK: - Private Methods
    private func clearAll() {
        workings = ""
        calculatorWorkings.text = ""
        calculatorResults.text = ""
    }
    
    private func specialCharacter(char: Character) -> Bool {
        if char == "*" {
            return true
        } else if char == "/" {
            return true
        } else if char == "/" {
            return true
        } else if char == "+" {
            return true
        }
        return false
    }
    
    private func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    private func validInput() -> Bool {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings {
            if specialCharacter(char: char) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        for index in funcCharIndexes {
            var previous = -1
            
            if index == 0 {
                return false
            } else if index == workings.count - 1 {
                return false
            } else if previous != 1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
        return true
    }
    
    private func addToWorkings(value: String) {
        workings = workings + value
        calculatorWorkings.text = workings
    }
}
