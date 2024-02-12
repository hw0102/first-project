//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Hello World on 2/11/24.
//

import Foundation

struct EmojiArt {
    var background: URL?
    var emojis = [Emoji]()
    
    struct Emoji {
        let string: String
        var position: Position
        var size: Int
        
        struct Position {
            var x, y, z : Int
        }
    }
    
}
