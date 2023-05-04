//
//  DogsView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/3/23.
//

import Foundation
import SwiftUI

struct DogsView: View {
    @StateObject var viewModel = ViewModel()
    @State var selectedAnimal: Dog? = nil
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 320))]) {
                    ForEach(viewModel.filterDog) { dog in
                        AnimalPicImage(imgURL: dog.image.url, name: dog.name, countryCode: "abc" ,temperament: dog.temperament!)
                            .onTapGesture {
                                selectedAnimal = dog
                            }
                    }
                }
            }
            .task {
                await viewModel.fetchDogData()
            }
            .searchable(text: $viewModel.searchText)
            .sheet(item: $selectedAnimal) { animal in
                //Text(type(of: animal))
                DogDetailView(dog: animal)
            }
        }
        .navigationTitle("Dogs")
    }
}

struct DogsView_Previews: PreviewProvider {
    static var previews: some View {
        DogsView()
    }
}
