//
//  ContentView.swift
//  memorize
//
//  Created by Hello World on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
        }
        .padding()
        .foregroundStyle(Color.orange) // apply to all unspecified foregroundstyles
    }
}

struct CardView: View {
    @State var isFaceUp:Bool = false
    // this is temporary
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("😀").font(.largeTitle)
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
