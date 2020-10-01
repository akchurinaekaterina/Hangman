//
//  StartViewController.swift
//  Hangman
//
//  Created by Ekaterina Akchurina on 01.10.2020.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var mainImage : UIImageView!
    
    @IBAction func newGame (_ sender: UIButton) {
        guard let gameVC = storyboard?.instantiateViewController(identifier: "Game") as? ViewController else {return}
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @IBAction func continueGame (_ sender: UIButton) {
        
    }
    
    @IBAction func rules (_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var contButton: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    
    var buttons = [UIButton]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImage.image = UIImage(named: "logo.png")
        
        buttons += [newGameButton, contButton, rulesButton]
        for button in buttons {
            drawBorder(button)
        }

        // Do any additional setup after loading the view.
    }
    
    func drawBorder(_ button: UIButton) {
        button.backgroundColor = .clear
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemPink.cgColor
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
