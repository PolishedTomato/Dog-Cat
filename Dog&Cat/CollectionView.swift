//
//  CollectionView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/8/23.
//

import Foundation
import SwiftUI
import RealmSwift

struct CollectionView: View {
    let realm = try! Realm()
    
    var animals: Results<AnimalInfo>{
        realm.objects(AnimalInfo.self)
    }
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(animals, id: \.self){ animal in
                    VStack{
                        Text("\(animal.name)")
                            .font(.headline.bold())
                        AsyncImage(url: URL(string: animal.URL)) { img in
                            img.resizable()
                                .scaledToFit()
                                .cornerRadius(16)
                        } placeholder: {
                            Image(systemName: "person.fill")
                        }
                    }
                    .cornerRadius(16)
                    .shadow(radius: 16)
                }
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
