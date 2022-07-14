//
//  ViewControllerSecond.swift
//  MVC
//
//  Created by Masaie on 6/7/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!

    var calculator: Calculator!

    override func viewDidLoad() {
        super.viewDidLoad()
        calculator = Calculator()
        reset()
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        if calculator.validInput() {
            calculator.equalsPressed()
            resultsLabel.text = calculator.operationsResult
        } else {
            let alert = UIAlertController(
                title: "Данные введены не корректно",
                message: "Калькулятор не может выполнять данное вычисление",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default)
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        calculator.deletePressed()
        currentLabel.text = calculator.working
    }

    @IBAction func operationButtonPressed(_ sender: UIButton) {
        
        var operation = ""

        let tag = sender.tag

        if tag == 1 {
            operation = "+"
        } else if tag == 2 {
            operation = "-"
        } else if tag == 3 {
            operation = "*"
        } else if tag == 4 {
            operation = "/"
        } else {
            operation = "%"
        }
        
        addToWorkings(value: operation)
    }

    @IBAction func numberOrDecimalButtonPressed(_ sender: UIButton) {
        
        if sender.tag == 10 {
            addToWorkings(value: ".")
        } else {
            addToWorkings(value: String(sender.tag))
        }
    }
    
    private func reset() {
        calculator.clearCurrent()
        currentLabel.text = ""
        resultsLabel.text = ""
    }
    
    private func addToWorkings(value: String) {
        calculator.addToWorking(value: value)
        currentLabel.text = calculator.working
    }
}
