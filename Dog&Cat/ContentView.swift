//
//  ContentView.swift
//  Dog&Cat
//
//  Created by Deye Lei on 4/20/23.
//

import SwiftUI

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
    
    var body: some View {
        NavigationView(){
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
                
                HStack(alignment:.center){
                    NavigationLink("go!"){
                        if(species == .dog){
                            DogsView()
                        }
                        else{
                            CatsView()
                        }
                    }
                    
                    NavigationLink("See collection"){
                        CollectionView()
                    }
                }
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(species == .dog ? .blue : .pink)
                .cornerRadius(10)
                //.buttonStyle(.borderedProminent)
                .padding(.top,200)
                
                
            }
            .padding()
            .navigationTitle("Dog&Cat")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
