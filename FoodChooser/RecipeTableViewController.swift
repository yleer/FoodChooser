//
//  RecipeTableViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/16.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    let headers = [
        "x-rapidapi-key": "4be4004724msh04a4366f0fdf175p12039ajsn50ececf3194a",
        "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    let endPointString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query="
    var searchString : String?
    let imageBaseUrl = "https://spoonacular.com/recipeImages/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = endPointString + searchString!
        netwrok(urlStr: urlString)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "go to broswer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            
            if segue.identifier == "go to broswer"{
                let destinationVC = segue.destination as! RecipeBrowserViewController
                destinationVC.recipeUrl = decodedData?.results[selectedRow].sourceUrl
            }
        }
        
        
    }
    
    
    
    func netwrok(urlStr : String){
        if let url = URL(string: urlStr){
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
                        self.decodedData = decode
                        
                    }catch{
                        print("not good \(error )")
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    var decodedData : FoodRecipe?{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if let recipe = decodedData{
            return recipe.results.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe cell", for: indexPath)
        cell.textLabel?.text = decodedData?.results[indexPath.row].title
        
        return cell
    }
}





//[
//    FoodChooser.FoodRecipe.Result(title: "Pork & Ramen Stir-Fry", sourceUrl: "http://www.julieseatsandtreats.com/2013/08/pork-ramen-stir-fry/", readyInMinutes: 30, image: "Pork---Ramen-Stir-Fry-519307.png"),
//    FoodChooser.FoodRecipe.Result(title: "Crunchy Asian Ramen Noodle Salad (Pretty Much The Best Potluck Salad EVER)", sourceUrl: "http://www.gimmesomeoven.com/crunchy-asian-ramen-noodle-salad/", readyInMinutes: 45, image: "Crunchy-Asian-Ramen-Noodle-Salad-(Pretty-Much-The-Best-Potluck-Salad-EVER)-603214.jpg"),
//    FoodChooser.FoodRecipe.Result(title: "Ridiculously Amazing Asian Ramen Salad", sourceUrl: "http://www.tablefortwoblog.com/ridiculously-amazing-asian-ramen-salad/", readyInMinutes: 130, image: "Ridiculously-Amazing-Asian-Ramen-Salad-593833.jpg"),
//    FoodChooser.FoodRecipe.Result(title: "Ramen Vegetable Soup", sourceUrl: "http://www.thecomfortofcooking.com/2012/09/ramen-vegetable-soup.html", readyInMinutes: 45, image: "Ramen-Vegetable-Soup-590798.jpg"),
//    FoodChooser.FoodRecipe.Result(title: "Asian Ramen-Chicken Chopped Salad", sourceUrl: "http://www.cookingclassy.com/2014/10/asian-ramen-chicken-chopped-salad/", readyInMinutes: 45, image: "Asian-Ramen-Chicken-Chopped-Salad-618532.jpg"),
//    FoodChooser.FoodRecipe.Result(title: "Ramen Chicken Noodle Soup", sourceUrl: "http://www.delish.com/cooking/recipe-ideas/recipes/a49382/ramen-chicken-noodle-soup-recipe/", readyInMinutes: 20, image: "ramen-chicken-noodle-soup-822463.jpg"),
//    FoodChooser.FoodRecipe.Result(title: "Chicken Ramen Stir-Fry", sourceUrl: "http://www.foodnetwork.com/recipes/katie-lee/chicken-ramen-stir-fry.html", readyInMinutes: 35, image: "chicken-ramen-stir-fry-737574.jpeg"),
//    FoodChooser.FoodRecipe.Result(title: "Ramen Crust Pizza", sourceUrl: "http://www.seriouseats.com/recipes/2013/09/ramen-crust-pizza-recipe.html", readyInMinutes: 30, image: "Ramen-Crust-Pizza-196529.jpg"),
//    FoodChooser.FoodRecipe.Result(title: "Japanese Ramen Noodle Soup", sourceUrl: "http://www.bbcgoodfood.com/recipes/722637/japanese-ramen-noodle-soup", readyInMinutes: 30, image: "japanese-ramen-noodle-soup-828579.jpg"),
//    FoodChooser.FoodRecipe.Result(title: "Crunchy Asian Ramen Noodle Salad (a.k.a. Basically the Best Potluck Salad EVER)", sourceUrl: "https://www.gimmesomeoven.com/crunchy-asian-ramen-noodle-salad/", readyInMinutes: 10, image: "crunchy-asian-ramen-noodle-salad-a-k-a-basically-the-best-potluck-salad-ever-880727.jpg")
//]
