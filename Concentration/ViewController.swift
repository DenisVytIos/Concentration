//
//  ViewController.swift
//  Concentration
//
//  Created by Denis on 09.01.2019.
//  Copyright © 2019 Denis Vitrishko. All rights reserved.
//

import UIKit

private struct ThemeEmoji {
    var name: String
    var emojis: [String]
    var viewColor: UIColor
    var cardColor: UIColor
}

extension Int{
    var arc4random:Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))}
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs (self))))
        }else{
            return 0
        }
    }
}

extension Array{
    mutating func shuffle(){
        if count < 2{
            return
        }
        
        for i in indices.dropLast() {
            let difference = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: difference.arc4random)
            swapAt(i, j)
        }
        
    }
}
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexEmojiThemes = emojiThemes.count.arc4random
        updateViewFromModel()
        
    }
    
   private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        get{
            return (cardButtons.count + 1) / 2
        }
    }
    
   
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBAction func newGame(_ sender: UIButton) {
        game.resetGame()
        indexEmojiThemes = emojiThemes.count.arc4random
        updateViewFromModel()
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("choosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardBackColor
            }
        }
        
        scoreLabel.text = "Score:\(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        
    }
   
    private var emoji = [Int: String]()
    
    private func emoji(for card:Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
                emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    private var emojiThemes:[ThemeEmoji] = [
        ThemeEmoji(name: "Fruits",
                  emojis:["🍏", "🍊", "🍓", "🍉", "🍇", "🍒", "🍌", "🥝", "🍆", "🍑", "🍋"],
                  viewColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
                  cardColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
        ThemeEmoji(name: "Faces",
                  emojis:["😀", "😂", "🤣", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎"],
                  viewColor: #colorLiteral(red: 1, green: 0.8999392299, blue: 0.3690503591, alpha: 1),
                  cardColor: #colorLiteral(red: 0.5519944677, green: 0.4853407859, blue: 0.3146183148, alpha: 1)),
        ThemeEmoji(name: "Activity",
                  emojis:["⚽️", "🏄‍♂️", "🏑", "🏓", "🚴‍♂️","🥋", "🎸", "🎯", "🎮", "🎹", "🎲"],
                  viewColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
                  cardColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)),
        ThemeEmoji(name: "Animals",
                  emojis:["🐶", "🐭", "🦊", "🦋", "🐢", "🐸", "🐵", "🐞", "🐿", "🐇", "🐯"],
                  viewColor: #colorLiteral(red: 0.8306297664, green: 1, blue: 0.7910112419, alpha: 1),
                  cardColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        ThemeEmoji(name: "Christmas",
                  emojis:["🎅", "🎉", "🦌", "⛪️", "🌟", "❄️", "⛄️","🎄", "🎁", "🔔", "🕯"],
                  viewColor: #colorLiteral(red: 0.9678710938, green: 0.9678710938, blue: 0.9678710938, alpha: 1),
                  cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
        ThemeEmoji(name: "Clothes",
                  emojis:["👚", "👕", "👖", "👔", "👗", "👓", "👠", "🎩", "👟", "⛱","🎽"],
                  viewColor: #colorLiteral(red: 0.9098039269, green: 0.7650054947, blue: 0.8981300767, alpha: 1),
                  cardColor: #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)),
        ThemeEmoji(name: "Halloween",
                  emojis:["💀", "👻", "👽", "🙀", "🦇", "🕷", "🕸", "🎃", "🎭","😈", "⚰"],
                  viewColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                  cardColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
        ThemeEmoji(name: "Transport",
                  emojis:["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"],
                  viewColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
                  cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
    ]
    private var indexEmojiThemes = 0 {
        didSet{
            print (indexEmojiThemes, emojiThemes[indexEmojiThemes].name)
            emoji = [Int: String] ()
            titleLabel.text = emojiThemes[indexEmojiThemes].name
            
            emojiChoices = emojiThemes[indexEmojiThemes].emojis
            backgroundColor = emojiThemes[indexEmojiThemes].viewColor
            cardBackColor = emojiThemes[indexEmojiThemes].cardColor
            
            updateAppearance()
    
        }
    }
    private var emojiChoices = [String] ()
    private var backgroundColor = UIColor.black
    private var cardBackColor = UIColor.orange
    
    private func updateAppearance() {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardBackColor
        scoreLabel.textColor = cardBackColor
        titleLabel.textColor = cardBackColor
        newGameButton.setTitleColor(backgroundColor, for: .normal)
        newGameButton.backgroundColor = cardBackColor
    }
  
   
    
}

