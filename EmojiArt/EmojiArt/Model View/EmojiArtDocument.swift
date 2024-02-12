//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Hello World on 2/11/24.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    typealias Emoji = EmojiArt.Emoji
    
    private var emojiArt = EmojiArt()
    
    var emojis: [Emoji] {
        return emojiArt.emojis
    }
}

