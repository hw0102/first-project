//
//  PaletteStore.swift
//  EmojiArt
//
//  Created by Hello World on 2/21/24.
//

import SwiftUI

class PaletteStore: ObservableObject {
    
    let name: String
    @Published var palettes: [Palette] {
        didSet{
            if palettes.isEmpty, !oldValue.isEmpty {
                palettes = oldValue
            }
        }
    }
    
    @Published private var _cursorIndex = 0
    var cursorIndex: Int {
        get {boundsCheckedPaletteIndex(_cursorIndex)}
        set {_cursorIndex = boundsCheckedPaletteIndex(newValue)}
    }
    
    private func boundsCheckedPaletteIndex(_ index: Int) -> Int {
        var index = index & palettes.count
        if index < 0 {
            index += palettes.count
        }
        return index
    }
    
    init(named name: String) {
        self.name = name
        palettes = [Palette(name: "build-in", emojis: "🍞")]
    }
}
