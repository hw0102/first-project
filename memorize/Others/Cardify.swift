//
//  Cardify.swift
//  memorize
//
//  Created by Hello World on 2/5/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
                
                base.strokeBorder(lineWidth: 2)
                    .background(base.fill(.white))
                    .overlay(content)
                    .opacity(isFaceUp ? 1 : 0)
            
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
    }
}
