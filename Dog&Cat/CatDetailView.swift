//
//  CatDetailView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/7/23.
//

import Foundation
import SwiftUI
import RealmSwift

struct CatDetailView: View {
    let cat : Cat
    let imgUrl: String?
    
    let realm = try! Realm()
    
    //get the width size of content string
    func getSize(fontSize: CGFloat, content: String)->CGFloat{
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let attribute = [NSAttributedString.Key.font: font]
        
        let size = (content as NSString).size(withAttributes: attribute)
        
        return size.width
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                if let alt_name = cat.alt_names{
                    if(alt_name != ""){
                        HStack{
                            Text(cat.name + "/" + alt_name)
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .font(.title.bold())
                    }
                    else{
                        HStack{
                            Text(cat.name)
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .font(.title.bold())
                    }
                }
                else{
                    HStack{
                        Text(cat.name)
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .font(.title.bold())
                }
                
                AsyncImage(url: URL(string:imgUrl ?? "")) { img in
                    img.resizable()
                        .scaledToFit()
                        .cornerRadius(50)
                } placeholder: {
                    Image(systemName: "person.fill")
                }
                .padding(.bottom, 25)
                
                if let description = cat.description{
                    
                    
                    Text("Description ")
                        .font(.headline)
                    
                    Rectangle()
                        .frame(height: 0.1)
                    
                    Text(description)
                    
                    Rectangle()
                        .frame(height: 0.5)
                }
                
                ScrollView{
                    HStack{
                        Text("Origin: \(cat.origin ?? "Unkown")")
                        Spacer()
                        Text("Life Span: \(cat.life_span ?? "Unkown")")
                    }
                    .font(.subheadline.bold())
                }
                
                if let temperature = cat.temperament{
                    let temerature_array = temperature.components(separatedBy: ", ")
                    VStack(alignment: .leading){
                        Text("Characteristic: ")
                            .font(.headline.bold())
                        TagView(maxLimit: 16, tags: temerature_array.map{Tag(text: $0, size: getSize(fontSize: 16, content: $0))}, frontSize: 16)
                    }
                }
                
                RatingComponent(cat: cat)
                
                Button("Add to collection"){
                    let newCat = AnimalInfo(name: cat.name, URL: imgUrl ?? "")
                    try! realm.write{
                        realm.add(newCat)
                    }
                }
            }
            .padding()
        }
    }
}


