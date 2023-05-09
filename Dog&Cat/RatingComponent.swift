//
//  RatingComponent.swift
//  Dog&Cat
//
//  Created by Deye Lei on 5/7/23.
//

import Foundation
import SwiftUI

struct RatingComponent: View {
    let cat: Cat
    var body: some View {
        VStack(alignment: .leading){
            if let adaptability = cat.adaptability{
                HStack{
                    Text("Adaptablity: ")
                        .font(.headline.bold())
                    Spacer()
                    RatingView(rate: adaptability, bound: 5)
                }
            }
            
            Group{
                if let affection_level = cat.affection_level{
                    HStack{
                        Text("Affection_level: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: affection_level, bound: 5)
                    }
                }
                
                if let child_friendly = cat.child_friendly{
                    HStack{
                        Text("Child_friendly: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: child_friendly, bound: 5)
                    }
                }
                
                if let dog_friendly = cat.dog_friendly{
                    HStack{
                        Text("Dog_friendly: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: dog_friendly, bound: 5)
                    }
                }
                
                if let energy_level = cat.energy_level{
                    HStack{
                        Text("Energy_level: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: energy_level, bound: 5)
                    }
                }
                
                if let grooming = cat.grooming{
                    HStack{
                        Text("Grooming: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: grooming, bound: 5)
                    }
                }
                
                if let health_issues = cat.health_issues{
                    HStack{
                        Text("Health_issues: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: health_issues, bound: 5)
                    }
                }
                
                if let intelligence = cat.intelligence{
                    HStack{
                        Text("Intelligence: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: intelligence, bound: 5)
                    }
                }
                
                if let shedding_level = cat.shedding_level{
                    HStack{
                        Text("Shedding_level: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: shedding_level, bound: 5)
                    }
                }
                
                if let social_needs = cat.social_needs{
                    HStack{
                        Text("Social_needs: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: social_needs, bound: 5)
                    }
                }
                
                if let stranger_friendly = cat.stranger_friendly{
                    HStack{
                        Text("Stranger_friendly: ")
                            .font(.headline.bold())
                        Spacer()
                        RatingView(rate: stranger_friendly, bound: 5)
                    }
                }
            }
        }
        .padding(.leading, 6)
        .padding(.vertical, 6)
    }
}


