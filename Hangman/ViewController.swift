//
//  ViewController.swift
//  Hangman
//
//  Created by Ekaterina Akchurina on 28.09.2020.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerText: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var used: UILabel!
    
    @IBAction func goButton(_ sender: Any) {
        submitTheAnswer()
    }
    
    
    var wordsArray = [String]()
    var numbOfGame = 0
    var encryptedWord = "" {
        didSet {
            title = encryptedWord
        }
    }
    var currentWord = ""
    var score = 0 {
        didSet {
            scoreLabel.text = "Your score: \(score)"
        }
    }
    var steps = 7 {
        didSet {
            switch steps {
            case 7:
                imageView.image = UIImage(named: "step0.png")
            case 6:
                imageView.image = UIImage(named: "step1.png")
            case 5:
                imageView.image = UIImage(named: "step2.png")
            case 4:
                imageView.image = UIImage(named: "step3.png")
            case 3:
                imageView.image = UIImage(named: "step4.png")
            case 2:
                imageView.image = UIImage(named: "step5.png")
            case 1:
                imageView.image = UIImage(named: "step6.png")
            case 0:
                imageView.image = UIImage(named: "step7.png")
                score -= 1
                let losingAlert = UIAlertController(title: "UNFORTUNATELY", message: "YOU HAVE LOST", preferredStyle: .alert)
                losingAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(losingAlert, animated: true, completion: nil)
            default: steps = 7
            }
        }
    }
    var characters = [Character]()
    var usedLetters = [String]()
    var usedString = "" {
        didSet {
            used.text = usedString
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerText.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        title = "Hangman Game"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadWord))
        imageView.image = UIImage(named: "step0.png")
        loadWord()
    }
    
    func loadWord() {
        if let wordsFileURL = Bundle.main.url(forResource: "words-en", withExtension: ".txt") {
            if let wordsString = try? String(contentsOf: wordsFileURL) {
                var words = wordsString.components(separatedBy: "\n")
                words.shuffle()
                wordsArray = words
                currentWord = wordsArray[numbOfGame].uppercased()
                encrypt(currentWord)
            }
        }
        
        usedString = ""
    }
    @objc func reloadWord(){
        usedLetters.removeAll()
        if numbOfGame < wordsArray.count-1 {
            numbOfGame += 1
        } else {
            numbOfGame = 0
        }
        currentWord = wordsArray[numbOfGame].uppercased()
        steps = 7
        encrypt(currentWord)
        usedString = ""
    }
    func encrypt(_ word: String){
        print(word)
        encryptedWord = ""
        if word == "" {
            reloadWord()
        } else {
            for letter in word {
                let str = String(letter)
                if usedLetters.contains(str) {
                    encryptedWord += str
                } else {
                    encryptedWord += "?"
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        submitTheAnswer()
        return true
    }
    func submitTheAnswer(){
        
            guard let text = answerText.text?.uppercased() else {return}
            answerText.text = ""
            if text.count != 1 {
                let mistake = UIAlertController(title: "OOPS", message: "You need to type one letter", preferredStyle: .alert)
                mistake.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                }))
                present(mistake, animated: true, completion: nil)
                return
            }
            if !usedLetters.contains(text) {
            usedLetters.append(text)
            }
            
            if !usedLetters.isEmpty {
                usedString = ""
            for letter in usedLetters {
                usedString += "\(letter) "
            }
            }
            if !currentWord.contains(text) {
                steps -= 1
            }
            encrypt(currentWord)
            if encryptedWord == currentWord {
                score += 1
                let winningAc = UIAlertController(title: "congratulations", message: "you have guessed the word", preferredStyle: .alert)
                winningAc.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.reloadWord()
                }))
                present(winningAc, animated: true, completion: nil)
            }
            
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}

