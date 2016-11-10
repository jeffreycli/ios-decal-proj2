//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var guessSingleLetterField: UITextField!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var wordToGuess: UILabel!
    @IBOutlet weak var incorrectGuessedLetters: UILabel!
    
    var phraseArray = [String]()
    var guessedLetters = [String]()
    var incorrectGuessedLettersArray = [String]()
    var incorrectGuessCount = 0
    var keywordPhrase = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newGame()
    }
    
    func newGame() {
        phraseArray = []
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        var initializeUnderscores = ""
        for character in (phrase?.characters)! {
            if character != " " {
                initializeUnderscores = initializeUnderscores + "_ "
                phraseArray.append(String(character))
            } else {
                initializeUnderscores = initializeUnderscores + "  "
            }
        }
        
        wordToGuess.text = initializeUnderscores
        incorrectGuessedLetters.text = ""
        keywordPhrase = phrase!
        hangmanImage.image = UIImage(named: "hangman1.gif")
        guessedLetters = []
        incorrectGuessedLettersArray = []
        incorrectGuessCount = 0
    }
    
    
    @IBAction func guessButtonPressed(_ sender: Any) {
        let guessedLetter = guessSingleLetterField.text?.uppercased()
        
        if guessedLetters.contains(guessedLetter!) {
            return
        } else {
            guessedLetters.append(guessedLetter!)
        }
        
        if (guessedLetter?.characters.count)! != 1 {
            return
        }
        

        if !phraseArray.contains(guessedLetter!) {
            incorrectGuessedLettersArray.append(String(guessedLetter!))
            incorrectGuessedLetters.text = incorrectGuessedLettersArray.joined(separator: ", ")
            incorrectGuessCount += 1
            addLimb()
        } else {
            var wordToGuessUpdate = ""
            for character in (keywordPhrase.characters) {
                if guessedLetters.contains(String(character)) {
                    wordToGuessUpdate = wordToGuessUpdate + String(character)
                } else if character != " " {
                    wordToGuessUpdate = wordToGuessUpdate + "_ "
                } else {
                    wordToGuessUpdate = wordToGuessUpdate + "   "
                }
            }
            wordToGuess.text = wordToGuessUpdate
        }
        
        if userWinsGame() {
            let alertController = UIAlertController(title: "You win!", message:
                "Congratulations, you won the game!", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default,handler: {action in self.viewDidLoad()}))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        if userLosesGame() {
            let alertController = UIAlertController(title: "You lost!", message:
                "The phrase was: " + keywordPhrase, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.default,handler: {action in self.viewDidLoad()}))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        guessSingleLetterField.text = ""
        
    }

    func userWinsGame() -> Bool {
        for correctLetter in phraseArray {
            if !guessedLetters.contains(correctLetter) {
                return false
            }
        }
        return true
    }
    
    func userLosesGame() -> Bool {
        if incorrectGuessCount < 6 {
            return false
        } else {
            return true
        }
    }
    
    func addLimb() {
        if incorrectGuessCount == 1 {
            hangmanImage.image = UIImage(named: "hangman2.gif")
        } else if incorrectGuessCount == 2 {
            hangmanImage.image = UIImage(named: "hangman3.gif")
        } else if incorrectGuessCount == 3 {
            hangmanImage.image = UIImage(named: "hangman4.gif")
        } else if incorrectGuessCount == 4 {
            hangmanImage.image = UIImage(named: "hangman5.gif")
        } else if incorrectGuessCount == 5 {
            hangmanImage.image = UIImage(named: "hangman6.gif")
        } else if incorrectGuessCount == 6 {
            hangmanImage.image = UIImage(named: "hangman7.gif")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
