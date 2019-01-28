//
//  Concentration.swift
//  Concentration
//
//  Created by Denis on 11.01.2019.
//  Copyright © 2019 Denis Vitrishko. All rights reserved.
//

import Foundation
    
extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first : nil
    }
    
}
struct Concentration {
    
    private (set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set (newValue){
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    mutating func chooseCard(at index:Int) {
        assert(cards.indices.contains(index), "Concentration.choosesCard(at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
  
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you mast have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
        let card = Card()
            cards += [card,card]
        }
        //TODO: Shuffle the card
    }
    
}
