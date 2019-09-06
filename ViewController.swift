//  ViewController.swift
//  Concentration
//
//  Coding as done by Instructor CS193P Michel Deiman on 11/11/2017.
//  Copyright © 2017 Michel Deiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
    var game: Concentration!
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
	
//    private(set) var flipCount = game.getFlipCount() {
//        didSet {
//            flipCountLabel.text = "Flips: \(flipCount)"
//        }
//    }
//    private(set) var score = 0 {
//        didSet {
//            scoreLabel.text = "Score: \(score)"
//        }
//    }
    let themes = ["animals":[[#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]:["🐴","🦄","🐝","🐛","🦋","🐌","🐚","🐞"]],
                  "sports":[[#colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]:["🎣","🥊","🥋","🎽","⛸","🥌","🛷","⛷"]],
                  "faces":[[#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)]:["🤢","🤮","😵","🤬","😤","😴","😎","🤠"]],
                  "vehicles":[[#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1),#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)]:["🛸","🚁","🛶","🚌","🚎","🏎","🚓","✈️"]],
                  "food":[[#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]:["🍗","🍖","🌭","🍔","🍟","🍕","🥪","🥙"]],
                  "shapes":[[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)]:["♠️","♣️","♥️","♦️","🔴","🔵","🔺","🔻"]]]
    
    
	
	@IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    
	@IBOutlet private var cardButtons: [UIButton]!
	
	
	@IBAction private func touchCard(_ sender: UIButton) {
		game.incFlipCount()
        flipCountLabel.text = "Flips: \(game.getFlipCount())"
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("choosen card was not in cardButtons")
		}
	}
    
    @IBAction private func gameReset(_ sender: UIButton) {
        startNewGame()
    }
    func startNewGame() {
        //score = 0**********
        //none of the cards are matched. All are face down
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCountLabel.text = "Flips: \(game.getFlipCount())"
        scoreLabel.text = "Score: \(game.getScore())"
        //emojiChoices_copy = emojiChoices
        emojiChoices_copy = []
        chosen_theme = [:]
        colors = []
        chooseTheme()
        emojiChoices_copy = Array(chosen_theme.values)[0]
        colors = Array(chosen_theme.keys)[0]
        self.view.backgroundColor = colors[1]
        for index in cardButtons.indices {
            cardButtons[index].backgroundColor = colors[0]
        }
        for button in cardButtons {
            button.setTitle("", for: UIControl.State.normal)
        }
    }
    
    override func viewDidLoad() {
        startNewGame()
    }
    
    
	
	func updateViewFromModel() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControl.State.normal)
				button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : colors[0]
			}
		}
        scoreLabel.text = "Score: \(game.getScore())"
	}
    
    func chooseTheme() {
        theme_keys = Array(themes.keys)
        theme_copy = themes
        chosen_theme = theme_copy.removeValue(forKey: theme_keys[(theme_keys.count-1).arc4random])!
        
        
    }
	
	//private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "😎", "😤"]//added two faces on the end of the array
    var emojiChoices_copy = [String]()
    var theme_keys = [String]()
    var theme_copy = [String:[[UIColor]:[String]]]()
    var chosen_theme = [[UIColor]:[String]]()
    var colors = [UIColor]()

	
	private var emoji = [Int: String]()
	
	private func emoji(for card: Card) -> String {
        //var emojiChoices_copy = emojiChoices
        if emoji[card.identifier] == nil, emojiChoices_copy.count > 0 {
            emoji[card.identifier] = emojiChoices_copy.remove(at: (emojiChoices_copy.count-1).arc4random)
        }
		return emoji[card.identifier] ?? "?"
	}
}

extension Int {
    var arc4random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
    }
}














