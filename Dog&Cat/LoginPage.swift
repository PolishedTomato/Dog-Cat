//
//  LoginPage.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/9/23.
//

import Foundation
import SwiftUI
import RealmSwift

struct LoginPage: View {
    @Binding var user: User?
    @State var userName = ""
    @State var passWord = ""
    let realm = try! Realm()
    
    @State var loginFalse = false
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Form{
                    Section("Sign in"){
                        VStack{
                            TextField("Enter user name", text: $userName)
                            SecureField("Enter password", text: $passWord)
                        }
                    }
                    
                    Button("Login") {
                        let allUser = realm.objects(User.self)
                        let targetUser = allUser.where {
                            $0.userName == userName
                        }
                        
                        if targetUser.isEmpty{
                            loginFalse = true;
                        }
                        else{
                            if targetUser[0].passWord != passWord{
                                loginFalse = true;
                            }
                            else{
                                //login success
                                loginFalse = false;
                                user = targetUser[0]
                            }
                        }
                    }
                    .disabled(userName.isEmpty || passWord.isEmpty)
                    
                    if loginFalse{
                        Text("user name or password not match")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                
                
                NavigationLink("New User?"){
                    //do something
                    CreateUserView(realm: realm, user: $user)
                }
                .font(.title)
                .foregroundColor(.green)
            }
        }
    }
}

