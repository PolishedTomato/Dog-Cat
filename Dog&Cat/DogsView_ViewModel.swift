//
//  DogsView_ViewModel.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/3/23.
//

import Foundation

extension DogsView{
    @MainActor class ViewModel: ObservableObject{
        @Published var dogs: [Dog] = []
        //cat id to img url
        @Published var searchText = ""
        
        var filterDog: [Dog]{
            if(searchText == ""){
                return dogs
            }
            else{
                return dogs.filter{
                    $0.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        
        let TheDogApi = "https://api.thedogapi.com/v1/breeds"
        
        func fetchDogData()async{
            
            guard let URL = Foundation.URL(string: TheDogApi) else{
                print("The Dog API URL failed")
                return
            }
            
            guard let (data, _) = try? await URLSession.shared.data(from: URL) else{
                print("URL session faield")
                return
            }
            
            do{
                dogs = try JSONDecoder().decode([Dog].self, from: data)
                print("decode sucess")
                return
            }
            catch{
                print("Decode failed")
            }
        }
        
        
    }
    
}
