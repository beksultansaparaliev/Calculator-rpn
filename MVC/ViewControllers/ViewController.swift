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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        model = Model()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        
        if model.currentWorking == "" {
            showAlert(title: "Отсутствие выражения",
                      message: "Пожалуйста введите выражение",
                      actionTitle: "OK"
            )
        } else {
            model.doAction()
            resultsLabel.text = model.rpnResult
        }
    }
    
    @IBAction func numberOrDecimalButtonPressed(_ sender: UIButton) {
        if sender.tag == 10 {
            model.currentWorking == "" ? sendToExpression(value: "0.") : sendToExpression(value: ".")
        } else {
            sendToExpression(value: String(sender.tag))
        }
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        
        if model.currentWorking == "" {
            showAlert(title: "Операнды не введены",
                      message: "Пожалуйста, начните выражение с операндов",
                      actionTitle: "OK"
            )
        } else {
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
    
    private func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: actionTitle,
            style: .default)
        )
        self.present(alert, animated: true, completion: nil)
    }
}
