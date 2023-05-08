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
    @State var selectedCat: Cat? = nil
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 320))]) {
                    ForEach(viewModel.filterCat) { cat in
                        AnimalPicImage(imgURL: viewModel.imgDic[cat.id], name: cat.name, countryCode: cat.country_codes ?? "N/A" ,temperament: cat.temperament!)
                            .onTapGesture {
                                selectedCat = cat
                            }
                    }
                }
            }
            .task {
                await viewModel.fetchCatData()
                await viewModel.buildImgDic()
            }
            .sheet(item: $selectedCat, content: { cat in
                CatDetailView(cat: cat, imgUrl: viewModel.imgDic[cat.id])
            })
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
