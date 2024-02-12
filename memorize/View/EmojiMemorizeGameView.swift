//
//  EmojiMemorizeGameView.swift
//  memorize
//
//  Created by Hello World on 1/7/24.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    typealias Card = MemorizeGame<String>.Card
    // link to view model - @ObservedObject means if this changes, redraw me
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    private let aspectRatio:CGFloat = 2/3
    
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            HStack {
                score
                Spacer()
                deck.foregroundStyle(Color.orange) // disappears because there's no undealt card
                Spacer()
                shuffle
            }
            // cardAdjuster
        }
        .padding()
    }
 
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle"){
            // this is a user intent. View Models translate user intents to backend actions
            
            withAnimation {
                viewModel.shuffle()
                
            }
            
            print(viewModel.cards)
        }
    }

    private var cards: some View{
        
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            
            if isDealt(card){
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(4)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1: 0)
                    .onTapGesture {
                        choose(card)
                    }
//                    .transition(.offset(
//                        x: CGFloat.random(in: -1000...1000),
//                        y: CGFloat.random(in: -1000...1000)
//                    ))
            }
           
        }
        .foregroundStyle(.orange)
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    // .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            // deal the cards
            var delay: TimeInterval = 0
            for card in viewModel.cards {
                withAnimation(.easeInOut(duration: 1).delay(delay)) {
                        _ = dealt.insert(card.id)
                }
                delay += 0.15
            }
        }
    }
    
    private let deckWidth: CGFloat = 50
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    private var undealtCards: [Card] {
        viewModel.cards.filter{ !isDealt($0) }
    }
    
    private func choose(_ card: Card){
        withAnimation {
            let scoreBeforeChooisng = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChooisng
            lastScoreChange = (scoreChange, card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
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


#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
