//
//  Breeds.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/20/23.
//

import Foundation

class DogAPIResponse: Codable{
    
    var message:[String:[String]]
    var status: String
}


class ImageAPIResponse: Codable{
    var message: String
    var status: String
}

