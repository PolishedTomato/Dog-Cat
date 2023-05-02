//
//  DecodingClasses.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/24/23.
//

import Foundation

struct Cat:Codable, Identifiable{
    var weight: Weight
    struct Weight: Codable{
        var imperial: String
        var metric: String
    }
    
    var id : String
    var name: String
    var cfa_url: String?
    var vetstreet_url: String?
    var vcahospitals_url: String?
    var temperament : String?
    var origin: String?
    var country_codes: String?
    var description: String?
    var life_span: String?
    var indoor:Int?
    var lap: Int?
    var alt_names: String?
    var adaptability: Int?
    var affection_level :Int?
    var child_friendly:Int?
    var dog_friendly:Int?
    var energy_level:Int?
    var grooming:Int?
    var health_issues:Int?
    var intelligence:Int?
    var shedding_level:Int?
    var social_needs:Int?
    var stranger_friendly:Int?
    var vocalisation:Int?
    var experimental:Int?
    var hairless:Int?
    var natural:Int?
    var rare:Int?
    var rex:Int?
    var suppressed_tail:Int?
    var short_legs:Int?
    var wikipedia_url:String?
    var hypoallergenic:Int?
    var reference_image_id:String?
}

extension Cat{
    var URL:String {
         "https://api.thecatapi.com/v1/images/search?breed_ids=\(self.id)"
    }
    
    //get the img url of target cat
    func getCatImgURL()async->String{
        guard let url = Foundation.URL(string: URL) else{
            print("get img url fail")
            return ""
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url)else{
            print("url session failed in get CatImgURL")
            return ""
        }
        
        do{
            let response = try JSONDecoder().decode([CatImg].self, from: data)
            print("img decode success")
            if(response.count == 0) {return ""}
            return response[0].url
        }
        catch{
            print("img decode failed")
            return ""
        }
    }
    
    private func countryNameToCountrycode(for fullCountryName : String) -> String {
        var locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales.lowercased()
    }
}

struct CatImg: Codable{
    var id: String
    var url: String
    var width: Int
    var height: Int
}
