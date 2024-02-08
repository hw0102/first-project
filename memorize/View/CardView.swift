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
        Pie(endAngle: Angle.degrees(200))
            .opacity(0.4)
            .overlay(
                Text(card.content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode:.fit)
                    .padding(5)
            )
            .padding(5)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}

#Preview {
    // typealias Card = MemorizeGame<String>.Card
    CardView(MemorizeGame<String>.Card(isFaceUp: true, content: "X", id: "Test"))
        .foregroundStyle(.green)
        .padding()
        
}
