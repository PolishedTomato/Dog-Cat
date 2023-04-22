//
//  AnimalsSubBreedView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/21/23.
//

import Foundation
import SwiftUI

struct AnimalsSubBreedView: View {
    @StateObject var viewModel = AnimalsSubBreedView_ViewModel()
    let breed:String
    let subBreed: [String]
    let type: Species
    
    init(breed: String, SubBreed: [String], type: Species){
        self.breed = breed
        self.subBreed = SubBreed
        self.type = type
    }
    
    var filterSubBreed : [String]{
        if(viewModel.searchCritic == ""){
            return subBreed
        }
        else{
            return subBreed.filter{
                $0.localizedCaseInsensitiveContains(viewModel.searchCritic)
            }
        }
    }
    
    let layout:[GridItem] = [GridItem(.adaptive(minimum: 320))]
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: layout){
                    ForEach(filterSubBreed, id: \.self) { subbreed in
                        let imgURL = viewModel.imgDic[subbreed]
                        AnimalPicImage(imgURL: imgURL, name: breed + "-" + subbreed)
                    }
                }
            }
            .task{
                await viewModel.fetchAllPic(breed: breed,  subBreed: subBreed, type: type)
            }
            .searchable(text: $viewModel.searchCritic)
            
        }
        .navigationTitle("\(breed)")
    }
}

struct AnimalsSubBreedView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsSubBreedView(breed: "bulldog", SubBreed: ["french","english", "boston"], type: .dog)
    }
}
