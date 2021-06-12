//
//  Constants.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/06/04.
//

import Foundation

struct Constants {
    // Main View Controller
    static let cornerRadius: CGFloat = 20
    static let mainNavBarColor = UIColor(red: 0.79, green: 0.85, blue: 0.93, alpha: 1.00)
    
    
    // Recipe Table View controller
    
    
    static let imageBaseUrl = "https://spoonacular.com/recipeImages/"
    static let receipEndPoint = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query="
    
    static let recipeNavBarRed : CGFloat = 0.51
    static let recipeNavBarGreen : CGFloat = 0.72
    static let recipeNavBarBlue : CGFloat = 0.82
    static let recipeNavBarAlpha : CGFloat = 1
    
    
    static let cellBackground : UIColor = UIColor(red: 0.51, green: 0.72, blue: 0.82, alpha: 1.00)
    static let cellBaseView : UIColor = UIColor(red: 0.85, green: 0.95, blue: 0.86, alpha: 1.00)
    static let cellTextColor : UIColor = UIColor(red: 0.30, green: 0.32, blue: 0.60, alpha: 1.00)
    static let cellCornerRadius : CGFloat = 15
    static let cellSize : CGFloat = 100
    
    
    // API keys
    static let rapidAPIKey = "Your API key"
    static let rapidAPIHost = "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    static let kakaoAuth = "Your API key"
}
