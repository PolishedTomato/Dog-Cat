//
//  DogDetailView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/3/23.
//

import Foundation
import SwiftUI
import RealmSwift

struct DogDetailView: View {
    let dog: Dog
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
                HStack{
                    Text(dog.name)
                    Spacer()
                }
                .foregroundColor(.black)
                .font(.title.bold())
                
                AsyncImage(url: URL(string:dog.image.url)) { img in
                    img.resizable()
                        .scaledToFit()
                        .cornerRadius(50)
                } placeholder: {
                    Image(systemName: "person.fill")
                }
                .padding(.bottom, 25)
                
                if let description = dog.description{
                    
                    
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
                        Text("Origin: \(dog.origin ?? "Unkown")")
                        Spacer()
                        Text("Life Span: \(dog.life_span ?? "Unkown")")
                    }
                    .font(.subheadline.bold())
                }
                
                if let breedPurpose = dog.bred_for{
                    let b = breedPurpose.components(separatedBy: ", ")
                    VStack(alignment: .leading){
                        Text("Breed for: ")
                            .font(.headline.bold())
                        TagView(maxLimit: 16, tags: b.map{
                            Tag(text: $0, size: getSize(fontSize: 16, content: $0))
                        }, frontSize: 16)
                    }
                }
                
                
                if let temperature = dog.temperament{
                    let temerature_array = temperature.components(separatedBy: ", ")
                    VStack(alignment: .leading){
                        Text("Characteristic: ")
                            .font(.headline.bold())
                        TagView(maxLimit: 16, tags: temerature_array.map{Tag(text: $0, size: getSize(fontSize: 16, content: $0))}, frontSize: 16)
                    }
                }
                
                Button("Add to collection"){
                    let newDog = AnimalInfo(name: dog.name, URL: dog.image.url)
                    try! realm.write{
                        realm.add(newDog)
                    }
                }
            }
            .padding()
        }
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(dog: Dog(weight: Dog.Unit(imperial: "1", metric: "1"), height: Dog.Unit(imperial: "1", metric: "1"), id: 1, name: "Husky", temperament: "Crazy, Smart, Fun-loving, asndkasdad",image: Dog.Image(id: "-HgpNnGXl", width: 500, height: 500, url: "https://cdn2.thedogapi.com/images/-HgpNnGXl.jpg"), description: "this is a good dog"))
    }
}

