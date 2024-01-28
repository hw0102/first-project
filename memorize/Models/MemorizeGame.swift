//
//  MemorizeGame.swift
//  memorize
//
//  Created by Hello World on 1/23/24.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // add 2 x cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    func choose (_ card: Card){
        
    }
    
    struct Card: Equatable{
        // MARK: you don't need to specify the following function
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.isFaceUp == rhs.isFaceUp &&
//            lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
//        }
        
        var isFaceUp: Bool = true // default to false
        var isMatched: Bool = false // default to false
        let content: CardContent // don't need content to change
    }
}
