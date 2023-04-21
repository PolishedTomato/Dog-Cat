//
//  Image.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/20/23.
//

import Foundation
import SwiftUI

extension Image{
    //use data class with UIImage(data:) to make UIimage, and then convert to Image
    func data(urlStr: String?) async ->Self{
        if let urlStr = urlStr{
            if let url = URL(string: urlStr){
                if let (data,_) = try? await URLSession.shared.data(from: url){
                    return Image(uiImage: UIImage(data: data)!)
                        .resizable()
                }
            }
        }
        
        return self.resizable()
    }
}
