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
    
    init() {
        emojiArt.addEmoji("🍞", at: .init(x: -200, y: -150), size: 200)
        emojiArt.addEmoji("🍳", at: .init(x: 250, y: 100), size: 80)
    }
    
    var emojis: [Emoji] {
        return emojiArt.emojis
    }
    
    var background: URL? {
        emojiArt.background
    }
    
    // MARK: Intent(s)
    
    func setBackground(_ url: URL?) {
        emojiArt.background = url
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat) {
        emojiArt.addEmoji(emoji, at: position, size: Int(size))
    }

}

extension EmojiArt.Emoji {
    var font: Font {
        Font.system(size:CGFloat(size))
    }
}

