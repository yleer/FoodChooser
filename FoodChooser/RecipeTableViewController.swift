//
//  RecipeTableViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/16.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    private let headers = [
        "x-rapidapi-key": Constants.rapidAPIKey ,
        "x-rapidapi-host": Constants.rapidAPIHost
    ]

    let endPointString = Constants.receipEndPoint
    let imageBaseUrl = Constants.imageBaseUrl
    var searchString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = searchString! + " Recipes"
        let urlString = endPointString + searchString!
        netwrok(urlStr: urlString)
        view.backgroundColor = Constants.mainNavBarColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = Constants.mainNavBarColor
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
                destinationVC.recipeName = decodedData?.results[selectedRow].title
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
        
        cell.backgroundColor = Constants.mainNavBarColor
//        cell.baseView.backgroundColor = Constants.cellBaseView
        cell.baseView.layer.cornerRadius = Constants.cellCornerRadius
        cell.foodTitle.textColor = Constants.cellTextColor
        
        cell.foodDuration.textColor = Constants.cellTextColor
        
        
//        let url = URL(string: imageBaseUrl + decodedData!.results[indexPath.row].image)
//        let data = try! Data(contentsOf: url!)
//        cell.foodThumNail.image = UIImage(data: data)
        
        
        
        cell.thumnailUrl = URL(string: imageBaseUrl + decodedData!.results[indexPath.row].image)
        cell.foodTitle.text = decodedData?.results[indexPath.row].title
        let a  = String(describing: decodedData!.results[indexPath.row].readyInMinutes)
        cell.foodDuration.text = a + "분 걸림."
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellSize
    }
    
    
    
}

