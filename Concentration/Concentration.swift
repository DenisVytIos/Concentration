//
//  Concentration.swift
//  Concentration
//
//  Created by Denis on 11.01.2019.
//  Copyright © 2019 Denis Vitrishko. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    func chooseCard(at index:Int) {
        if cards[index].isFaceUp{
            cards[index].isFaceUp = false
        }else{
            cards[index].isFaceUp = true
        }
        
    }
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
        let card = Card()
            cards += [card,card]
        }
        //TODO: Shuffle the card
    }
    
}
