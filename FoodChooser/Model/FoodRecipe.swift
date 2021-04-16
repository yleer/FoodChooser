//
//  FoodRecipe.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/12.
//

import Foundation

struct FoodRecipe : Codable {
    let results : [Result]
    
    struct Result : Codable {
        let title : String
        let sourceUrl : String
        let readyInMinutes : Int
        let image : String
    }
}
