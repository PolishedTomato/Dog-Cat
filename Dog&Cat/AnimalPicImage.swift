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
    let countryCode: String
    let temperament: String
    
    var temperament_array:[String]{
        temperament.components(separatedBy: ", ")
    }
    
    var fontSize:CGFloat = 16
    
    var getTag: [Tag]{
        temperament_array.map{
            Tag(text: $0, size: getSize(fontSize: fontSize, content: $0))
        }
    }
    
    //get the width size of content string
    func getSize(fontSize: CGFloat, content: String)->CGFloat{
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let attribute = [NSAttributedString.Key.font: font]
        
        let size = (content as NSString).size(withAttributes: attribute)
        
        return size.width
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Text(name)
                Spacer()
            }
            .foregroundColor(.black)
            .font(.title.bold())
            
            AsyncImage(url: URL(string: imgURL ?? "")) { img in
                img.resizable()
                    .scaledToFit()
                    .cornerRadius(50)
            } placeholder: {
                Image(systemName: "person.fill")
            }
            
            TagView(maxLimit: 150, tags: getTag, frontSize: fontSize)
                .frame(height: 120)
            
            
        }
        .frame(width: 320, height:400)
        .padding(.bottom, 30)
    }
}

struct AnimalPicImage_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPicImage(imgURL: "", name: "husky", countryCode: "us", temperament: "Crazy, Active, Good, Intelligent, asdsjdsand, asdnasdjnasdjnsakd, asdasdj ,sadaskdjnajdkandknsakdnakdnakjdnakdnkandkasndkandkandknadkandkandnkadnad")
    }
}
