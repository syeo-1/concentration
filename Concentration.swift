//
//  Concentration.swift
//  Lecture 2 - Concentration
//
//  Created by Michel Deiman on 13/11/2017.
//  Copyright © 2017 Michel Deiman. All rights reserved.
//

import Foundation

class Concentration {
	
	private(set) var cards = [Card]()
    
    private var flipCount = 0
    func incFlipCount() {
        flipCount += 1
    }
    func getFlipCount() -> Int {
        return flipCount
    }
    
    private var score = 0
    func getScore() -> Int {
        return score
    }
    
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    guard foundIndex == nil else { return nil }
                    foundIndex = index
                    //cards[index].isSeen = true
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
	
	func chooseCard(at index: Int) {
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards match
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
                    score += 2
                } else if cards[matchIndex].isSeen && cards[index].isSeen {
                    score -= 2
                } else if cards[matchIndex].isSeen || cards[index].isSeen {
                    score -= 1
                }
				cards[index].isFaceUp = true
                
                //user has now seen both cards
                cards[index].isSeen = true
                cards[matchIndex].isSeen = true
			} else {
				// either no card or two cards face up
				indexOfOneAndOnlyFaceUpCard = index
			}
			
		}
	}
    func shuffle() {
        for index in 0..<cards.count {
            var temp: Card
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count - 1)))
            temp = cards[index]
            cards[index] = cards[randomIndex]
            cards[randomIndex] = temp
        }
    }
	
	init(numberOfPairsOfCards: Int) {
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
	//	TODO: Shuffle the cards
        self.shuffle()
        
        
	}
	
}
