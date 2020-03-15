//
//  ViewController.swift
//  Flashcards
//
//  Created by Ino on 2/21/20.
//  Copyright © 2020 Ino Ts. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var option1: String
    var option2: String
    var option3: String
}

class ViewController: UIViewController {

    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    //array that holds flashcards
    var flashcards = [Flashcard]()
    
    //counter to intex through flashcards array
    var currentIndex = 0
    
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
        
        //read saved flashcards (if any)
        readSavedFlashcards()
        
        //crate and add initial flashcard to the array (if needed)
        if flashcards.count == 0{
            updateFlashcard(newQuestion: "What is the smallest country in the world?", newAnswer: "Vatican City", extraAnswerOne: "Monaco", extraAnswerTwo: "Vatican City", extraAnswerThree: "Nauru")
        } else{
            updateLabels()
            updateNextPrevButtons()
        }
        
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
        
        let flashcard = Flashcard(question: newQuestion, answer: newAnswer, option1: extraAnswerOne, option2: extraAnswerTwo, option3: extraAnswerThree)
        
        //show all possible options
        option1.isHidden = false
        option2.isHidden = false
        option3.isHidden = false
        question.isHidden = false
       
        //append new flashcard in Flashcards array
        flashcards.append(flashcard)
        
        //update current index
        currentIndex = flashcards.count - 1
        
        //Logging to the console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
            
        // update buttons
        updateNextPrevButtons()
        //update labels
        updateLabels()
        //save array to UserDefaults
        saveAllFlashcardsToDisk()
        
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
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //increase current index
        currentIndex = currentIndex + 1
        //update labels
        updateLabels()
        //update buttons
        updateNextPrevButtons()

    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        //decrease current index
        currentIndex = currentIndex - 1
        
        //update Labels
        updateLabels()
        
        //update buttons
        updateNextPrevButtons()
    }
    
    func updateNextPrevButtons(){
        print("currIndex\(currentIndex)")
        //disable next button if at last card
        if (currentIndex == flashcards.count - 1) {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        } else {
            nextButton.isEnabled = true
            nextButton.alpha = 1
        }
        print("currIndex2\(currentIndex)")
        print(currentIndex == 0)
        //disable prev button if at the beginning
        if (currentIndex == 0) {
            prevButton.isEnabled = false
            prevButton.alpha = 0.5
        } else{
            prevButton.isEnabled = true
            prevButton.alpha = 1
        }
    }
    
    func updateLabels() {
        
        //get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //show all possible options
        option1.isHidden = false
        option2.isHidden = false
        option3.isHidden = false
        question.isHidden = false
        
        //update labels
        question.text = currentFlashcard.question
        answer.text = currentFlashcard.answer
        option1.setTitle(currentFlashcard.option1, for: .normal)
        option2.setTitle(currentFlashcard.option2, for: .normal)
        option3.setTitle(currentFlashcard.option3, for: .normal)
    }
    
    func saveAllFlashcardsToDisk(){
        //Flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return["question": card.question, "answer": card.answer, "option1": card.option1, "option2": card.option2, "option3": card.option3]
        }
        
        //save array on disk using user defaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //console log
        print("Flashcards saved to UserDefaults!")
    }
    
    func readSavedFlashcards(){
        //read array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            //in here we know we have a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, option1: dictionary["option1"]!, option2: dictionary["option2"]!, option3: dictionary["option3"]!)
            }
            
            //put all saved cards in flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
}

