//
//  RulesViewController.swift
//  Hangman
//
//  Created by Ekaterina Akchurina on 01.10.2020.
//

import UIKit

class RulesViewController: UIViewController {
    
    @IBOutlet weak var rulesText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rulesText.text = """
            An app thinks of a word. The Player try to guess what it is one letter at a time.
            The app draws a number of  "?" equivalent to the number of letters in the word. If a player suggests a letter that occurs in the word, the app fills in the blanks with that letter in the right places. If the word does not contain the suggested letter, the app draws one element of a hangman’s gallows. As the game progresses, a segment of the gallows and of a victim is added for every suggested letter not in the word. The number of incorrect guesses before the game ends is seven. Good luck.
            """
        
        title = "Rules"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(newGame))

        // Do any additional setup after loading the view.
    }
    
    @objc func newGame(){
        guard let gameVC = storyboard?.instantiateViewController(identifier: "Game") as? ViewController else {return}
        navigationController?.pushViewController(gameVC, animated: true)
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
