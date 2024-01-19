//
//  ContentView.swift
//  memorize
//
//  Created by Hello World on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    
    let emojis: Array<String> = ["🚜","🩼","🚡","🚃","🚘"]
    
    var body: some View {
        HStack{
            ForEach(emojis.indices, id: \.self){ index in
                CardView(content: emojis[index])
            }
        
        }
        .padding()
        .foregroundStyle(Color.orange) // apply to all unspecified foregroundstyles
    }
}

struct CardView: View {
    let content:String
    @State var isFaceUp:Bool = true
    // this is temporary
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            else{
                base.fill()
            }
            
        }.onTapGesture {
            print("tapped")
            isFaceUp.toggle()
            // isFaceUp.toggle()
        }
    }
}
#Preview {
    ContentView()
}
