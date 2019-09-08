//
//  ViewController.swift
//  concentration
//
//  Created by Roman Zakharov on 08/09/2019.
//  Copyright © 2019 Роман Захаров. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        startNewGame()
        super.viewDidLoad()
    }
    
    lazy var game = ConcentrationGameModel(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var theme: Theme!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : theme.cardBackColor
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    var emojiChoices = [String]()
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func touchNewGameButton() {
        startNewGame()
    }
    
    @IBAction func startNewGame() {
        theme = themes.randomElement()
        guard theme != nil else {
            print("Theme is nil")
            
            return
        }
        emojiChoices = theme.emoji
        view.backgroundColor = theme.backgroundColor
        emoji = [:]
        game = ConcentrationGameModel(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
    }
}

