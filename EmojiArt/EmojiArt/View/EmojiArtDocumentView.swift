//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Hello World on 2/11/24.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    typealias Emoji = EmojiArt.Emoji
    
    @ObservedObject var document: EmojiArtDocument
    
    private let paletteEmojiSize: CGFloat = 40
    private let emojis = "⌚️🥎🛼🧄🍝🌮🍟🍖"
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            ScrollingEmojis(emojis)
                .font(.system(size: paletteEmojiSize))
                .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
    
    private var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                documentContents(in: geometry)
                    .scaleEffect(zoom)
                    .offset(pan)
            }
            .dropDestination(for: URL.self) {urls, location in
                return drop(urls, at: location, in: geometry)
            }
        }
    }
    
    @State private var zoom: CGFloat = 1 // How much it is zoomed
    @State private var pan: CGSize = .zero
    
    @ViewBuilder
    private func documentContents(in geometry: GeometryProxy) -> some View {
        AsyncImage(url: document.background)
            .position(Emoji.Position.zero.in(geometry))
        ForEach(document.emojis) { emoji in
            Text(emoji.string)
                .font(emoji.font)
                .position(emoji.position.in(geometry))
        }
    }
    private func drop(_ urls: [URL], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        if let url = urls.first {
            document.setBackground(url)
            return true
        }
        return false
    }
}

struct ScrollingEmojis: View{
    let emojis : [String]
    
    init(_ emojis: String) {
        self.emojis = emojis.uniqued.map(String.init)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .draggable(emoji)
                }
            }
        }
    }
}

extension EmojiArt.Emoji.Position {
    func `in`(_ geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(self.x), y: center.y - CGFloat(self.y)) // upside down coordinate system
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    init(center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x - size.width/2, y: center.y - size.height/2), size: size)
    }
}

extension String {
    var uniqued: String {
        reduce(into: ""){ sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
}

#Preview {
    EmojiArtDocumentView(document: EmojiArtDocument())
}
