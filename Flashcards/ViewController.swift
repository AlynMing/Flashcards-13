//
//  ViewController.swift
//  Flashcards
//
//  Created by Ino on 2/21/20.
//  Copyright © 2020 Ino Ts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.isUserInteractionEnabled = true
        card.layer.cornerRadius = 20.0
        answer.layer.cornerRadius = 20.0
        question.layer.cornerRadius = 20.0
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 2.0
        
        answer.clipsToBounds = true
        question.clipsToBounds = true
        
        option1.layer.cornerRadius = 20.0
        option2.layer.cornerRadius = 20.0
        option3.layer.cornerRadius = 20.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = question.text
            creationController.initialAnswer = answer.text
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {

        if(question.isHidden){
            question.isHidden = false
        }else{
            question.isHidden = true
        }
    }
    
    func updateFlashcard(newQuestion: String, newAnswer: String, extraAnswerOne: String, extraAnswerTwo: String, extraAnswerThree: String) {
        question.text = newQuestion
        answer.text = newAnswer
        
        option1.isHidden = false
        option2.isHidden = false
        option3.isHidden = false
        question.isHidden = false
       
        option1.setTitle(extraAnswerOne, for: .normal)
        option2.setTitle(extraAnswerTwo, for: .normal)
        option3.setTitle(extraAnswerThree, for: .normal)
            
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        if answer.text == option1.titleLabel?.text {
            question.isHidden = true
        }
        option1.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if answer.text == option2.titleLabel?.text {
            question.isHidden = true
        }
        option2.isHidden = true
    }
    
    
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        if answer.text == option3.titleLabel?.text {
            question.isHidden = true
        }
        option3.isHidden = true
    }
    
    
    
}

