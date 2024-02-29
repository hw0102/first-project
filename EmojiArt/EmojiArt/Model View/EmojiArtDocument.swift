//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Hello World on 2/11/24.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    typealias Emoji = EmojiArt.Emoji
    
    init() {
        if let data = try? Data(contentsOf: autosaveURL),
           let autosavedEmojiArt = try? EmojiArt(json: data){
            emojiArt = autosavedEmojiArt
        }
    }
    
    @Published private var emojiArt = EmojiArt() {
        didSet {
            autosave()
        }
    }
    
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent("Autosaved.emojiart")
    
    private func autosave(){
        save(to: autosaveURL)
        print("autosaved to \(autosaveURL)")
    }
    
    private func save(to url: URL){
        do {
            let data = try emojiArt.json()
            try data.write(to: url)
        } catch let error {
            print("EmojiArtDocuement: error while saving \(error.localizedDescription)")
        }
    }
    
    init() {
        emojiArt.addEmoji("🍞", at: .init(x: -200, y: -150), size: 200)
        emojiArt.addEmoji("🍳", at: .init(x: 250, y: 100), size: 80)
    }
    
    var emojis: [Emoji] {
        return emojiArt.emojis
    }
    
    var background: URL? {
        return emojiArt.background
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

