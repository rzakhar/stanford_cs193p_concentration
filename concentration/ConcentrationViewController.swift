//
//  ConcentrationViewController.swift
//  concentration
//
//  Created by Roman Zakharov on 08/09/2019.
//  Copyright © 2019 Роман Захаров. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    override func viewDidLoad() {
        startNewGame()
        super.viewDidLoad()
        if theme == nil {
            scoreLabel.isHidden = true
            newGameButton.isHidden = true
        }
    }

    @IBOutlet weak var newGameButton: UIButton!
    private lazy var game = ConcentrationGameModel(numberOfPairsOfCards: numberOfPairsOfCards)

    var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }

    @IBOutlet private weak var scoreLabel: UILabel!

    @IBOutlet private var cardButtons: [UIButton]!

    var theme: Theme? = nil {
        didSet {
            emojiChoices = theme?.emojiString ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender),
            theme != nil {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }

    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : theme?.cardBackColor
                }
            }
            scoreLabel.text = "Score: \(game.score)"
            scoreLabel.isHidden = false
            newGameButton.isHidden = false
        }
        view.backgroundColor = theme?.backgroundColor
    }

    private var emojiChoices = String()

    private var emoji = [Card: String]()

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex,
                                                 offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }

    @IBAction private func touchNewGameButton() {
        startNewGame()
    }

    private func startNewGame() {
        game = ConcentrationGameModel(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
}
