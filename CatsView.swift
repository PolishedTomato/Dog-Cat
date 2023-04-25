//
//  CatsView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/24/23.
//

import Foundation
import SwiftUI

struct CatsView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 320))]) {
                    ForEach(viewModel.filterCat) { cat in
                        AnimalPicImage(imgURL: viewModel.imgDic[cat.id], name: cat.name)
                    }
                }
            }
            .task {
                await viewModel.fetchCatData()
                await viewModel.buildImgDic()
            }
            .searchable(text: $viewModel.searchText)
        }
        .navigationTitle("Cats")
    }
}

struct CatsView_Previews: PreviewProvider {
    static var previews: some View {
        CatsView()
    }
}
