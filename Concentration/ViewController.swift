//
//  ViewController.swift
//  Concentration
//
//  Created by ジョナサン on 9/9/20.
//  Copyright © 2020 ジョナサン. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1)/2
    }
    
    var emojiSets = [[String]]()
    var emojiChoices = ["👻", "🎃", "🍬", "🍭", "🍫", "🍪", "🍩", "🍦"]
    let set2 = ["🐼", "🐔", "🦄", "🦙", "🦘", "🦥", "🦨", "🐘"]
    var set3 = ["🏀", "🏈", "⚾", "⚽️", "🎾", "🏐", "🏓", "⛳️",]
    var set4 = ["😀", "😂", "🤣", "😁", "😜", "😎", "🤩", "😍"]
    var set5 = ["🚗", "🚕", "🚌", "🏎", "🚓", "🚑", "🚒", "🚜"]
    var set6 = ["🇺🇸", "🇨🇦", "🇲🇽", "🇧🇷", "🇬🇧", "🇯🇵", "🇨🇳", "🇰🇷"]
    
    override func viewDidLoad(){
        emojiSets = [set2, set3, set4, set5, set6];
    }
    
    var emoji = Dictionary<Int, String>()
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var scoreCount = 0 {
        didSet {
            scoreCountLabel.text = "Score: \(scoreCount)"
        }
    }
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                if card.isMatched {
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    scoreCount = game.score
                }
                else {
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                    scoreCount = game.score
                }
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
                //emojiChoices.remove(at: randomIndex)^
            }
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func getNewSet() -> Array<String> {
        return emojiSets.randomElement()!
    }
    
    func setNewSet() {
        let newSet = getNewSet();
        print(newSet);
        for index in emojiChoices.indices {
            emojiChoices[index] = newSet[index];
            emoji[index] = newSet[index]
        }
    }
    
    @IBAction func restart(_ sender: UIButton) {
        flipCount = 0
        scoreCount = 0
        setNewSet()
        game.shuffleCards()
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            game.cards[index].isFaceUp = true
            game.cards[index].isMatched = true
        }
    }
}

