//
//  RecipeViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/16.
//

import UIKit

class RecipeViewController: UIViewController {
    
    let headers = [
        "x-rapidapi-key": "4be4004724msh04a4366f0fdf175p12039ajsn50ececf3194a",
        "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    var endPointString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query="
    var searchString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = endPointString + searchString!
        netwrok(urlStr: urlString)
        
        
        
        
    }
    
    func netwrok(urlStr : String){
        if let url = URL(string: urlStr)
        {
            let request = NSMutableURLRequest(
                url: url,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0
            )
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error!)
                }else {
                    let decoder = JSONDecoder()
                    do{
                        let decode = try decoder.decode(FoodRecipe.self, from: data!)
                        print(decode.results.count)
                    }catch{ 
                        print("not good \(error )")
                    }
                }
            })
            dataTask.resume()
        }
    }
}
