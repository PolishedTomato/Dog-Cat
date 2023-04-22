//
//  AnimalsSubBreedView_ViewModel.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/21/23.
//

import Foundation

extension AnimalsSubBreedView{
    @MainActor class AnimalsSubBreedView_ViewModel:ObservableObject{
        @Published var searchCritic: String = ""
        var imgDic: [String: String] = [:]
        
        func apiURL(breedName: String, subBreedName:String, type: Species)->String{
            if(type == .dog){
                return "https://dog.ceo/api/breed/\(breedName)/\(subBreedName)/images/random"
            }
            else{
                //for cat
                return ""
            }
        }
        
        //return api for the pic
        func fetchPicURL(requestURL: String)async->String{
            if let url = URL(string: requestURL){
                if let (data, _) = try? await URLSession.shared.data(from: url){
                    do{
                        let response = try JSONDecoder().decode(ImageAPIResponse.self, from: data)
                        return response.message
                    }
                    catch{
                        return ""
                    }
                }
            }
            return ""
        }
        
        //get all the pic url into cooresping dic
        func fetchAllPic(breed: String, subBreed: [String], type: Species)async{
            for subBREED in subBreed{
                imgDic[subBREED] = await fetchPicURL(requestURL: apiURL(breedName: breed, subBreedName: subBREED, type: type))
            }
        }
    }
}
