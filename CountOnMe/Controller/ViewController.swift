//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private let userInput = UserInput()
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalcul(notification:)), name: .updateTextMessage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertCalcul(notification:)), name: .alertMessage, object: nil)
    }
    @objc private func displayCalcul(notification: Notification) {
        if let userInfo = notification.userInfo {
            textView.text = userInfo["updateMessage"] as? String
        } else {
            return
        }
    }
    @objc private func alertCalcul(notification: Notification) {
        guard let alertInfo = notification.userInfo!["message"] as? String else { return }
               newAlert(message: alertInfo)
    }
    private func newAlert(message: String) {
        let alertVC = UIAlertController(title: "Attention !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        userInput.numberButtonTapped(buttonTitle: numberText)
    }
    @IBAction func operationButtonsTapped(_ sender: UIButton) {
        guard let sign = sender.title(for: .normal) else { return }
        userInput.tappedOperationButtons(operatorString: sign)
    }
    @IBAction func acButtonTapped(_ sender: UIButton) {
        userInput.tappedAc()
    }
    @IBAction func pointButtonTapped(_ sender: UIButton) {
        userInput.TappedPointButton()
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        userInput.tappedEqualButton()
    }
}
