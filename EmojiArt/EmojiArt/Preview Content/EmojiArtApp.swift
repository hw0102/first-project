//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Hello World on 2/11/24.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    @StateObject var defaultDocument = EmojiArtDocument()
    @StateObject var paletteStore = PaletteStore(named: "Main")
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
                .environmentObject(PaletteStore(named: "Preview"))
        }
    }
}
