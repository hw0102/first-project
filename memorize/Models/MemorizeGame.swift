//
//  MemorizeGame.swift
//  memorize
//
//  Created by Hello World on 1/23/24.
//

import Foundation

struct MemorizeGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // add 2 x cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{ index in cards[index].isFaceUp }.only
        }
        set {
            cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) }
            // new value is the new Int you are setting this to.
        }
    }
    
    mutating func choose (_ card: Card){
        print("chose \(card)")
        // if let chosenIndex = index(of: card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            // actual game logic
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }
                    else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
            //cards[chosenIndex].isFaceUp.toggle()
        }
        // do nothing if you can't find it
    }
    
//    private func index(of card: Card) -> Int? {
//        for index in cards.indices {
//            if cards[index].id == card.id {
//                return index
//            }
//        }
//        return nil
//    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        var debugDescription: String {
            "\(id): \(content)"
        }
        
        // MARK: you don't need to specify the following function
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.isFaceUp == rhs.isFaceUp &&
//            lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
//        }
        
        var isFaceUp: Bool = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        } // default to false
        var hasBeenSeen = false
        var isMatched: Bool = false // default to false
        let content: CardContent // don't need content to change
        var id: String

    }
}

extension Array {
    var only:Element? {
        return count == 1 ? first : nil
    }
}
