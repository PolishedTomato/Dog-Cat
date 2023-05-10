//
//  DataModel.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/8/23.
//

import Foundation
import RealmSwift

class AnimalInfo: Object{
    @Persisted(primaryKey: true) var _id : ObjectId
    @Persisted var name: String = ""
    @Persisted var URL: String = ""
    
    
    convenience init(name: String, URL: String) {
        self.init()
        self.name = name
        self.URL = URL
    }
}

class User: Object{
    @Persisted(primaryKey: true) var userName: String
    @Persisted var passWord: String
    @Persisted var likedAnimal: List<AnimalInfo>
    
    convenience init(userName: String, passWord: String) {
        self.init()
        self.userName = userName
        self.passWord = passWord
        self.likedAnimal = List<AnimalInfo>()
    }
}
