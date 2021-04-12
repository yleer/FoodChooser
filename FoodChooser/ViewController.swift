//
//  ViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/11.
//

import UIKit
 
class ViewController: UIViewController , UITextFieldDelegate{
    
    override func viewDidLoad() {
        textfield.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textfield.text)
        let search = urlString + textField.text!
        netwrok(urlStr: search)
    }
    
    @IBOutlet weak var textfield: UITextField!
    let headers = [
        "x-rapidapi-key": "4be4004724msh04a4366f0fdf175p12039ajsn50ececf3194a",
        "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    var urlString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query="
    
    
    
    
    
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
                        print(decode.results.first!)
                    }catch{ error
                        print("not good \(error )")
                    }
                }
            })
            dataTask.resume()
        }
    }
}


// Recipe - Food - Nutrition. api 사용. 먼저 음식 검색하면 그 음식에 대한 영양 정보 보이게 하자.

//"{\"results\":
//[
//    {\"id\":492564,\"title\":\"Falafel Burgers with Feta Cucumber Sauce\",\"readyInMinutes\":50,\"servings\":6,\"sourceUrl\":\"https://www.cinnamonspiceandeverythingnice.com/falafel-burgers-with-feta-tzatziki-sauce/\",\"openLicense\":0,\"image\":\"falafel-burgers-with-feta-tzatziki-sauce-492564.jpg\"
//
//    },{\"id\":246916,\"title\":\"Bison Burger\",\"readyInMinutes\":45,\"servings\":6,\"sourceUrl\":\"https://www.simplyrecipes.com/recipes/buffalo_burger/\",\"openLicense\":0,\"image\":\"Buffalo-Burger-246916.jpg\"
//
//    },{\"id\":245166,\"title\":\"Hawaiian Pork Burger\",\"readyInMinutes\":40,\"servings\":4,\"sourceUrl\":\"https://www.simplyrecipes.com/recipes/hawaiian_pork_burger/\",\"openLicense\":0,\"image\":\"Hawaiian-Pork-Burger-245166.jpg\"
//
//    },{\"id\":246009,\"title\":\"Blue Cheese Burgers\",\"readyInMinutes\":55,\"servings\":4,\"sourceUrl\":\"https://www.simplyrecipes.com/recipes/blue_cheese_burgers/\",\"openLicense\":0,\"image\":\"Blue-Cheese-Burgers-246009.jpg\"
//
//    },{\"id\":219957,\"title\":\"Carrot & sesame burgers\",\"readyInMinutes\":50,\"servings\":6,\"sourceUrl\":\"https://www.bbcgoodfood.com/recipes/11011/carrot-and-sesame-burgers\",\"openLicense\":0,\"image\":\"Carrot---sesame-burgers-219957.jpg\"
//
//    },{\"id\":607109,\"title\":\"Turkey Zucchini Burger with Garlic Mayo\",\"readyInMinutes\":45,\"servings\":6,\"sourceUrl\":\"https://www.simplyrecipes.com/recipes/turkey_zucchini_burger_with_garlic_mayo/\",\"openLicense\":0,\"image\":\"Turkey-Zucchini-Burger-with-Garlic-Mayo-607109.jpg\"
//
//    },{\"id\":864633,\"title\":\"Banh Mi Burgers with Spicy Sriracha Mayo\",\"readyInMinutes\":35,\"servings\":4,\"sourceUrl\":\"http://littlespicejar.com/banh-mi-burgers-with-spicy-sriracha-mayo/\",\"openLicense\":0,\"image\":\"banh-mi-burgers-with-spicy-sriracha-mayo-864633.jpg\"
//
//    },{\"id\":219871,\"title\":\"Halloumi aubergine burgers with harissa relish\",\"readyInMinutes\":20,\"servings\":4,\"sourceUrl\":\"https://www.bbcgoodfood.com/recipes/2196638/halloumi-aubergine-burgers-with-harissa-relish\",\"openLicense\":0,\"image\":\"Halloumi-aubergine-burgers-with-harissa-relish-219871.jpg\"
//
//    },{\"id\":246177,\"title\":\"Grilled Beef and Mushroom Burger\",\"readyInMinutes\":30,\"servings\":3,\"sourceUrl\":\"https://www.simplyrecipes.com/recipes/grilled_beef_and_mushroom_burger/\",\"openLicense\":0,\"image\":\"Grilled-Beef-and-Mushroom-Burger-246177.jpg\"
//
//    },{\"id\":245343,\"title\":\"Herbed Turkey Burger\",\"readyInMinutes\":30,\"servings\":8,\"sourceUrl\":\"https://www.simplyrecipes.com/recipes/herbed_turkey_burger/\",\"openLicense\":0,\"image\":\"Herbed-Turkey-Burger-245343.jpg\"
//
//    }
//],
//
//\"baseUri\":\"https://spoonacular.com/recipeImages/\",
//\"offset\":0,
//\"number\":10,
//\"totalResults\":179,
//\"processingTimeMs\":218,
//\"expires\":1618394822678,
//\"isStale\":false
//}
