//
//  EmojiMemorizeGameView.swift
//  memorize
//
//  Created by Hello World on 1/7/24.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    // link to view model
    var viewModel: EmojiMemorizeGame
    
    // Extra expliit. Can use type inference.
    let emojis: Array<String> = ["🚜","🩼","🚡","🚃","🚘"]
    @State var cardCount: Int = 4 // States are usually for demo purposes
    var body: some View {
        VStack{
        ScrollView{
            cards
        }
            Spacer()
         cardAdjuster
        }
        .padding()
    }
    
    var cardAdjuster: some View{
        HStack{
        cardAdder
            Spacer()
        cardDeleter
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundStyle(Color.orange) // apply to all unspecified foregroundstyles
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button{
            cardCount += offset
        } label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardAdder: some View{
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    var cardDeleter: some View{
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
}

struct CardView: View {
    let content:String
    @State var isFaceUp:Bool = true
    // this is temporary
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1:0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }.onTapGesture {
            print("tapped") // to remove
            isFaceUp.toggle()
            // isFaceUp.toggle()
        }
    }
}
#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
