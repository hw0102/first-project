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
            PaletteChooser()
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
                    .scaleEffect(zoom * gestureZoom) // this is for zoom
                    .offset(pan + gesturePan) // this is for pan
            }
            .gesture(zoomGesture.simultaneously(with: panGesture))
            .dropDestination(for: URL.self) {urls, location in
                return drop(urls, at: location, in: geometry)
            }
        }
    }
    
    private var panGesture: some Gesture {
        DragGesture()
            .updating($gesturePan) { value, gesturePan, _ in
                gesturePan = value.translation
            }
            .onEnded{ endValue in
                pan += endValue.translation
            }
    }
    
    private var zoomGesture: some Gesture {
        MagnificationGesture() // what is the difference between this and magnifyGesture?
            .updating($gestureZoom) { inMotionPinchScale, gestureZoom, _ in // how do I know it would give three parameters for me to use?
                gestureZoom = inMotionPinchScale
            }
            .onEnded { endingPinchScale in
                zoom *= endingPinchScale
            }
    }
    
    @State private var zoom: CGFloat = 1 // How much it is zoomed
    @State private var pan: CGSize = .zero
    
    @GestureState private var gestureZoom: CGFloat = 1
    @GestureState private var gesturePan: CGSize = .zero
    
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
    
    // Help translate between dropped and zoomed/panned coordinates
    private func emojiPosition(at location: CGPoint, in geometry: GeometryProxy) -> Emoji.Position {
        let center = geometry.frame(in: .local).center
        return Emoji.Position(
            x: Int((location.x - center.x - pan.width) / zoom),
            y: Int(-(location.y - center.y - pan.height) / zoom)
        )
    }
}



extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func +=(lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs + rhs
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
