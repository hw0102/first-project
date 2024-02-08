//
//  AspectVGrid.swift
//  memorize
//
//  Created by Hello World on 2/2/24.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: items.count,
                                                     size: geometry.size,
                                                     atAspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0){
                
                // id: is selecting a unique property (in this case itself) that identifies an instance
                ForEach(items){ item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    func gridItemWidthThatFits( // This is not working. Super strange. It is a carbon copy from lecture 6.
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        var columnCount = 1.0
        let count = CGFloat(count) // create a new locally scoped variable
        repeat{
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height{
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        // let _ = print("Value returned is \(size.height)")
        // not sure why size.height always stays static
        // return min(size.width / count, size.height * aspectRatio).rounded(.down)
        return 64
    }
}

