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
                        VStack{
                            AsyncImage(url: URL(string: imgURL ?? "")) { img in
                                img.resizable()
                                    .scaledToFit()
                                    .cornerRadius(50)
                            } placeholder: {
                                Image(systemName: "person.fill")
                            }

                            HStack{
                                Text(key + "\(viewModel.breedDic[key]!.count > 1 ? " family" : "")")
                            }
                            .font(.title.bold())
                        }
                        .frame(width: 320, height:400)
                        .padding(.bottom, 30)
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


