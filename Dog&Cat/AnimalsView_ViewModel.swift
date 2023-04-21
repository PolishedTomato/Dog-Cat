//
//  AnimalsView_ViewModel.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/21/23.
//

import Foundation

extension AnimalsView{
    @MainActor class ViewModel: ObservableObject{
        @Published var apiResponse: DogAPIResponse? = nil
        var imgDic: [String:String] = [:]
        
        var keys:[String]{
            if let response = apiResponse{
                return Array(response.message.keys)
            }
            return []
        }
        
        var breedDic:[String: [String]]{
            if let response = apiResponse{
                return response.message
            }
            return [:]
        }
        
        let DogAPI = "https://dog.ceo/api/breeds/list/all"
        
        //get api response from DogAPI which contain all breed's name and its sub breed
        func fetchAllBreed() async{
            if let url = URL(string: DogAPI){
                if let (data,_) = try? await URLSession.shared.data(from: url){
                    do{
                        apiResponse = try JSONDecoder().decode(DogAPIResponse.self, from: data)
                        return
                    }
                    catch{
                        apiResponse = nil
                    }
                }
            }
            
            apiResponse = nil
        }
        
        //get the api for random pic of a dog breed
        func randomPicApi(name: String) -> String{
            return "https://dog.ceo/api/breed/\(name)/images/random"
        }
        
        //get the url to the pic of this dog breed
        func getDogImageUrl(urlStr: String)async ->String {
            if let url = URL(string: urlStr){
                if let (data,_) = try? await URLSession.shared.data(from: url){
                    do{
                        let img_response = try JSONDecoder().decode(ImageAPIResponse.self, from: data)
                        return img_response.message
                    }
                    catch{
                        return ""
                    }
                }
            }
            return ""
        }
        
        //fetch all breed's img to cooresponding key
        func fetchImg()async{
            for key in keys{
                imgDic[key] = await getDogImageUrl(urlStr: randomPicApi(name: key))
            }
        }
        
        @Published var searchCritic = ""
        
        var filterKeys:[String]{
            if(searchCritic == ""){
                return keys
            }
            else{
                return keys.filter{
                    $0.localizedCaseInsensitiveContains(searchCritic)
                }
            }
        }
    }
}
