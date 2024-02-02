//
//  EmojiMemorizeGame.swift
//  memorize
//
//  Created by Hello World on 1/23/24.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    
    private static let emojis = ["🚜","🩼","🚡","🚃","🚘","💾"]
    
    // this is for a Memorize Game based on string
    private static func createMemoryGame() -> MemorizeGame<String> {
        return MemorizeGame<String>(numberOfPairsOfCards: 4){ pairIndex in // <string> is optional. You can call the arguments (in order) whatever you want
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }
            else{
                return "❌"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    // link back to model
//    private var model = MemorizeGame<String>(numberOfPairsOfCards: 4){ pairIndex in // <string> is optional. You can call the arguments (in order) whatever you want
//        return emojis[pairIndex]
//    }
    
//    private var model = MemorizeGame(numberOfPairsOfCards: 4){ $0 in // $0 is first argument
//        return ["🚜","🩼","🚡","🚃","🚘"][$0]
//    }
    
    
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    // FIXME: App is great

    
    // TODO: App is amazing
    
    // MARK: - Intents
    
    func shuffle(){
        model.shuffle()
    }
    
    // _ because it's always clear to caller that argument is a card
    func choose(_ card: MemorizeGame<String>.Card){
        model.choose(card)
    }
}
