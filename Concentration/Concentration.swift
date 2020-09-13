//
//  Concentration.swift
//  Concentration
//
//  Created by ジョナサン on 9/9/20.
//  Copyright © 2020 ジョナサン. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var score = 0;
    var singleFlipCount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        foundIndex = nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)//TF
            }
        }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else {
                    singleFlipCount[matchIndex] += 1
                    singleFlipCount[index] += 1
                    if singleFlipCount[index] > 1 || singleFlipCount[matchIndex] > 1 {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
            }
            else {
                //either 0 or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    func shuffleCards(){
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int){
        for identifier in 0..<numberOfPairsOfCards{
            let card = Card(identifier: identifier)
            cards += [card, card]//append 2 dif copys
        }
        shuffleCards()
    }
}
