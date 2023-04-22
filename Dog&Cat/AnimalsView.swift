//
//  AnimalsView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/20/23.
//

import Foundation
import SwiftUI

struct AnimalsView: View {
    @StateObject var viewModel = ViewModel()
    var layout:[GridItem] = [GridItem(.adaptive(minimum: 320))]
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: layout){
                    ForEach(viewModel.filterKeys, id: \.self) { key in
                        let imgURL = viewModel.imgDic[key]
                        if(viewModel.breedDic[key]!.count <= 1){
                            AnimalPicImage(imgURL: imgURL, name: key)
                        }
                        else{
                            NavigationLink {
                                AnimalsSubBreedView(breed: key, SubBreed: viewModel.breedDic[key]!, type: .dog)
                            } label: {
                                AnimalPicImage(imgURL: imgURL, name: key + " family")
                            }

                        }
                    }
                }
            }
            .task{
                await viewModel.fetchAllBreed()
                await viewModel.fetchImg()
            }
            .searchable(text: $viewModel.searchCritic)
        }
    }
}

struct AnimalsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsView()
    }
}


