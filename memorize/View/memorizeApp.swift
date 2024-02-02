//
//  memorizeApp.swift
//  memorize
//
//  Created by Hello World on 1/7/24.
//

import SwiftUI

@main
struct memorizeApp: App {
    @StateObject var game = EmojiMemorizeGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemorizeGameView(viewModel: game)
        }
    }
}
