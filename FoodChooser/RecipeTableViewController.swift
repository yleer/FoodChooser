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
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.51, green: 0.72, blue: 0.82, alpha: 1.00)

        view.backgroundColor = UIColor(red: 0.51, green: 0.72, blue: 0.82, alpha: 1.00)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe cell", for: indexPath) as! ReciepeTableViewCell
        
        
        cell.backgroundColor = UIColor(red: 0.51, green: 0.72, blue: 0.82, alpha: 1.00)
        cell.baseView.backgroundColor = UIColor(red: 0.85, green: 0.95, blue: 0.86, alpha: 1.00)
        cell.baseView.layer.cornerRadius = 15
        cell.foodTitle.textColor = UIColor(red: 0.30, green: 0.32, blue: 0.60, alpha: 1.00)
        
        cell.foodDuration.textColor = UIColor(red: 0.30, green: 0.32, blue: 0.60, alpha: 1.00)
        
        
        let url = URL(string: imageBaseUrl + decodedData!.results[indexPath.row].image)
        let data = try! Data(contentsOf: url!)
        cell.foodThumNail.image = UIImage(data: data)
        cell.foodTitle.text = decodedData?.results[indexPath.row].title
        let a  = String(describing: decodedData!.results[indexPath.row].readyInMinutes)
        cell.foodDuration.text = a + "분 걸림."
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

