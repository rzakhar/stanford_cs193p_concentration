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
    
    private lazy var game = ConcentrationGameModel(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private(set) var theme: Theme!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
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
    
    private var emojiChoices = [String]()
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.arc4random
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "?"
    }
    
    @IBAction private func touchNewGameButton() {
        startNewGame()
    }
    
    private func startNewGame() {
        theme = themes.randomElement()
        guard theme != nil else {
            print("Theme is nil")
            
            return
        }
        emojiChoices = theme.emoji
        view.backgroundColor = theme.backgroundColor
        emoji = [:]
        game = ConcentrationGameModel(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
}

