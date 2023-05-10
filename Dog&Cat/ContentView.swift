//
//  ContentView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/20/23.
//

import SwiftUI
import RealmSwift

enum Species{
    case dog, cat
}

struct ColorPicker{
    func giveColor(color: String)->Color{
        switch(color){
        case "Active", "Alert": return .red
        case "Energetic", "Playful": return .yellow
        case "Independent", "Intelligent", "Lively", "Easy Going", "Agile", "Fun-loving": return .green
        case "Gentle","Affectionate", "Interactive", "Loyle": return .pink
        case "Calm", "Curious": return .blue
        default: return .gray
        }
    }
}

struct ContentView: View {
    @State var species: Species = .cat
    @State var animationSize1 = 1.0
    @State var animationSize2 = 2.0
    
    @State var user : User? = nil
    var body: some View {
//        Button("delete"){
//            try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
//
//        }
        NavigationView(){
            if user != nil {
                VStack() {
                    HStack(spacing: 50){
                        Image("icons8-dog-50")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                if(species != .dog){
                                    species = .dog
                                    animationSize1 += 1
                                    animationSize2 = 1
                                }

                            }
                            .opacity(species == .dog ? 1 : 0.2)
                            .scaleEffect(species == .dog ? 1 : 0.75)
                            .overlay(content: {
                                Circle()
                                    .stroke(.blue)
                                    .opacity(animationSize1-1)
                                    .scaleEffect(animationSize1)
                            })
                            .animation(.easeInOut(duration: 0.5), value: species)

                        Image("icons8-cat-50")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                if(species != .cat){
                                    species = .cat
                                    animationSize1 = 1
                                    animationSize2 += 1
                                }
                                //default opacity = 0, and scaleeffect = 1, tapped all increase one
                            }
                            .opacity(species == .cat ? 1 : 0.2)
                            .scaleEffect(species == .cat ? 1 : 0.75)
                            .overlay(content: {
                                Circle()
                                    .stroke(.pink)
                                    .opacity(animationSize2 - 1)
                                    .scaleEffect(animationSize2)
                            })
                            .animation(.easeInOut(duration: 0.5), value: species)

                    }

                    HStack(alignment:.center, spacing: 50){
                        NavigationLink("go!"){
                            if(species == .dog){
                                DogsView(user: user!)
                            }
                            else{
                                CatsView(user: user!)
                            }
                        }
                        .frame(height: 50)
                        .padding()
                        .background(species == .dog ? .blue : .pink)
                        .cornerRadius(10)



                        NavigationLink("collection"){
                            CollectionView(user: user!)
                        }
                        .frame( height: 50)
                        .padding()
                        .background(species == .dog ? .blue : .pink)
                        .cornerRadius(10)
                        
                    }
                    .font(.title)
                    .foregroundColor(.white)
                    //.buttonStyle(.borderedProminent)
                    .padding(.top,200)


                }
                .padding()
                .navigationTitle("Dog&Cat")
            }
            else{
                LoginPage(user: $user)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
