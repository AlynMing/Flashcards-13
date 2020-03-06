//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Ino on 3/4/20.
//  Copyright © 2020 Ino Ts. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraAnswerOne: UITextField!
    @IBOutlet weak var extraAnswerTwo: UITextField!
    @IBOutlet weak var extraAnswerThree: UITextField!
    
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        //exit view
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        //let questionText = questionTextField.text
        //let answerText = answerTextField.text
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let option1Text = extraAnswerOne.text
        let option2Text = extraAnswerTwo.text
        let option3Text = extraAnswerThree.text
        //check if empty
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
        }else{
            //update flashcard with new values
            flashcardsController.updateFlashcard(newQuestion: questionText!, newAnswer: answerText!, extraAnswerOne: option1Text!, extraAnswerTwo: option2Text!, extraAnswerThree: option3Text!)
            //exit view
            dismiss(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
