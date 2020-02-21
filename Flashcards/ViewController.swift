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
        print("did load")
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

    @IBAction func didTapOnFlashcard(_ sender: Any) {

        if(question.isHidden){
            question.isHidden = false
        }else{
            question.isHidden = true
        }
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        option1.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        option2.isHidden = true
        question.isHidden = true
    }
    
    
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        option3.isHidden = true
    }
    
    
    
}

