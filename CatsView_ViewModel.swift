//
//  CatsView_ViewModel.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/24/23.
//

import Foundation

extension CatsView{
    @MainActor class ViewModel: ObservableObject{
        @Published var cats: [Cat] = []
        //cat id to img url
        @Published var imgDic: [String: String] = [:]
        @Published var searchText = ""
        
        var filterCat: [Cat]{
            if(searchText == ""){
                return cats
            }
            else{
                return cats.filter{
                    $0.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        
        let TheCatApi = "https://api.thecatapi.com/v1/breeds"
        
        func fetchCatData()async{
            
            guard let URL = Foundation.URL(string: TheCatApi) else{
                print("The Cat API URL failed")
                return
            }
            
            guard let (data, _) = try? await URLSession.shared.data(from: URL) else{
                print("URL session faield")
                return
            }
            
            do{
                cats = try JSONDecoder().decode([Cat].self, from: data)
                print("decode sucess")
                return
            }
            catch{
                print("Decode failed")
            }
        }
        
        func buildImgDic() async{
            for cat in cats{
                imgDic[cat.id] = await cat.getCatImgURL()
            }
        }
    }
}
