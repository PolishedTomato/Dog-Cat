//
//  CreateUserView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/9/23.
//

import Foundation
import SwiftUI
import RealmSwift

struct CreateUserView: View {
    let realm: Realm
    @Binding var user: User?
    @State var userName = ""
    @State var passWord = ""
    @State var creationFalse = false
    var body: some View {
        Form{
            Section {
                TextField("Enter new user name", text: $userName)
                TextField("Enter new password", text: $passWord)
            }
            if(creationFalse){
                Text("account exited")
                    .foregroundColor(.red)
                    .font(.headline)
            }
            
            Button("Create"){
                let allUser = realm.objects(User.self)
                let duplicate = allUser.where{
                    $0.userName == userName
                }
                
                if duplicate.isEmpty{
                    let newUser = User(userName: userName, passWord: passWord)
                    
                    try! realm.write{
                        realm.add(newUser)
                    }
                    user = newUser
                }
                else{
                    creationFalse = true
                }
            }
        }
    }
}
