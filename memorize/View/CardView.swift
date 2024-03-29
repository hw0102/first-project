//
//  CardView.swift
//  memorize
//
//  Created by Hello World on 2/5/24.
//

import SwiftUI

struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    
    
    var body: some View {
        if card.isFaceUp || !card.isMatched {
            Pie(endAngle: Angle.degrees(200))
                .opacity(0.4)
                .overlay(cardContents.padding(5))
                .padding(5)
                .cardify(isFaceUp: card.isFaceUp)
                //.transition(.scale)
        }
        else {
            Color.clear
        }
    }
    
    private var cardContents: some View {
        Text(card.content)
            .font(.system(size: 100))
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode:.fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
}



extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}

extension Animation{
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}

#Preview {
    // typealias Card = MemorizeGame<String>.Card
    CardView(MemorizeGame<String>.Card(isFaceUp: true, content: "X", id: "Test"))
        .foregroundStyle(.green)
        .padding()
        
}
