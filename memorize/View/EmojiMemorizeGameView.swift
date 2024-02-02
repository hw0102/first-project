//
//  EmojiMemorizeGameView.swift
//  memorize
//
//  Created by Hello World on 1/7/24.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    // link to view model - @ObservedObject means if this changes, redraw me
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    private let aspectRatio:CGFloat = 2/3
    
    var body: some View {
        VStack{
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("Shuffle"){
                // this is a user intent. View Models translate user intents to backend actions
                viewModel.shuffle()
                print(viewModel.cards)
            }
            // cardAdjuster
        }
        .padding()
    }
 

    private var cards: some View{
        
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card)
                .aspectRatio(2/3, contentMode: .fit)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundStyle(Color.orange) // apply to all unspecified foregroundstyle
    }
}
    
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
//        Button{
//            cardCount += offset
//        } label: {
//            Image(systemName: symbol)
//        }
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    
//    var cardAdder: some View{
//        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
//    }
//    var cardDeleter: some View{
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }

struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode:.fit)
            }.opacity(card.isFaceUp ? 1:0)
            
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        //.onTapGesture {
           // print("tapped") // to remove
            //card.isFaceUp.toggle()
            // isFaceUp.toggle()
        // }
    }
}
#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
