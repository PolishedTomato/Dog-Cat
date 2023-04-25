//
//  Breeds.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/20/23.
//

import Foundation

class DogAPIResponse: Codable{
    enum CodingKeys: String, CodingKey{
        case m = "message", s = "status"
    }
    
    var m:[String:[String]] = [:]
    var s: String = ""
}


class ImageAPIResponse: Codable{
    var message: String
    var status: String
}

