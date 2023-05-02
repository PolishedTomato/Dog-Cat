//
//  TagView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/2/23.
//

import Foundation
import SwiftUI

struct Tag: Identifiable, Hashable{
    var id = UUID()
    var text:String
    var size:CGFloat
}

struct TagView: View {
    var maxLimit: Int
    let tags: [Tag]
    let frontSize: CGFloat
    
    init(maxLimit: Int, tags: [Tag], frontSize: CGFloat) {
        self.maxLimit = maxLimit
        self.tags = tags
        self.frontSize = frontSize
    }
    
    //parition the array with given screen width, so we can place them into different vstack
    func getRows()->[[Tag]]{
        
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        
        //get screen width
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 90
        
        // 40 for two 14 at horizontal padding, 6 for spacing of HStack
        tags.forEach { tag in
            totalWidth += (tag.size + 40)
            if totalWidth > screenWidth {
                totalWidth = tag.size
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
            }
            else{
                currentRow.append(tag)
            }
        }
        
        if currentRow.count > 0 {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return rows
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 5){
                ForEach(getRows(), id: \.self) { row in
                    HStack(spacing: 6){
                        ForEach(row){ r in
                            Text(r.text)
                                .foregroundColor(.white)
                                .font(.system(size: frontSize))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(ColorPicker().giveColor(color: r.text))
                                )
                                //prevent it take more space
                                .lineLimit(1)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity)
    }
}
//
//struct TagView_Previews: PreviewProvider {
//    static var previews: some View {
//        TagView(maxLimit: 15, tags: ["abc", "cba"])
//    }
//}
