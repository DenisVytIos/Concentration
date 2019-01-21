//
//  Concentration.swift
//  Concentration
//
//  Created by Denis on 11.01.2019.
//  Copyright © 2019 Denis Vitrishko. All rights reserved.
//

import Foundation


extension Date{
    var sinceNow:Int{
        return -Int(self.timeIntervalSinceNow)
    }
    
}
class Concentration {
    
    private (set) var cards = [Card]()
    
    private (set) var flipCount = 0
    private (set) var score = 0
    private var seenAndUnmatchedCards: Set<Int> = []
    
    private var dateClick: Date?
    private var timePenalty: Int{
        return min(dateClick?.sinceNow ?? 0, BonusesAndPenalties.maxTimePenalty)
    }
    private struct BonusesAndPenalties {
        static let matchBonus       = 20
        static let missMatchPenalty = 10
        static let maxTimePenalty   = 10
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int? = nil
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil{
                        foundIndex = index
                    } else{
                        return nil
                    }
                }
            }
            return foundIndex
            
        }
        set (newValue){
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    func chooseCard(at index:Int) {
        assert(cards.indices.contains(index), "Concentration.choosesCard(at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    
                    //match
                    
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched      = true
                    
                    score += BonusesAndPenalties.matchBonus
                }else{
                    
                    //cards did not match
                    
                    if seenAndUnmatchedCards.contains(index){
                        score -= BonusesAndPenalties.missMatchPenalty
                    }
                    
                    if seenAndUnmatchedCards.contains(matchIndex){
                        score -= BonusesAndPenalties.missMatchPenalty
                    }
                    
                    seenAndUnmatchedCards.insert(index)
                    seenAndUnmatchedCards.insert(matchIndex)
                    
                }
                score -= timePenalty
                cards[index].isFaceUp = true
                
            }else{
                
                indexOfOneAndOnlyFaceUpCard = index
            }
            
            flipCount += 1
            dateClick = Date()
        }
        
    }
  
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you mast have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
        let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    func resetGame() {
        flipCount = 0
        score     = 0
        seenAndUnmatchedCards = []
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }
    
}
