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
    
    private var model : Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = Model()
        reset()
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        model.doAction()
        resultsLabel.text = model.rpnResult
    }
    
    @IBAction func numberOrDecimalButtonPressed(_ sender: UIButton) {
        if sender.tag == 10 {
            sendToExpression(value: ".")
        } else {
            sendToExpression(value: String(sender.tag))
        }
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
        
        sendToExpression(value: operation)
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        model.deleteLastSymbol()
        let result = model.displayWorking
        currentLabel.text = result
    }

    private func reset() {
        model.clearing()
        currentLabel.text = ""
        resultsLabel.text = ""
    }
    
    private func sendToExpression(value: String) {
        model.addToWorking(value: value)
        currentLabel.text = model.displayWorking
    }
}
