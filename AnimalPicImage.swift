//
//  AnimalPicImage.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/21/23.
//

import Foundation
import SwiftUI

struct AnimalPicImage: View {
    let imgURL: String?
    let name: String
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: imgURL ?? "")) { img in
                img.resizable()
                    .scaledToFit()
                    .cornerRadius(50)
            } placeholder: {
                Image(systemName: "person.fill")
            }
            if let url = imgURL{
                Text("this url is \(url == "" ? "nothing" : url)")
            }
            HStack{
                Text(name)
            }
            .foregroundColor(.black)
            .font(.title.bold())
        }
        .frame(width: 320, height:400)
        .padding(.bottom, 30)
    }
}

struct AnimalPicImage_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPicImage(imgURL: "", name: "husky")
    }
}
