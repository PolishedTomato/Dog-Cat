//
//  RatingView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/7/23.
//

import Foundation
import SwiftUI

struct RatingView: View {
    let rate: Int
    let bound: Int
    
    var selectedImage:Image{
        Image(systemName: "star.fill")
    }
    
    func finalImage(rating: Int)->some View{
        if rating <= rate{
            return selectedImage.foregroundColor(.yellow)
        }
        return selectedImage.foregroundColor(.gray)
    }
    
    var body: some View {
        HStack{
            ForEach(1...bound, id: \.self){ i in
                finalImage(rating: i)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rate: 5, bound: 10)
    }
}
