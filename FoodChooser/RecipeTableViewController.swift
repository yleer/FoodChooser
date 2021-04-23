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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = endPointString + searchString!
        netwrok(urlStr: urlString)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(decodedData?.results[indexPath.row].sourceUrl)
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
