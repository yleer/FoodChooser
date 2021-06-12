# FoodChooser

FoodChoose lets you easily choose a food from variety of cuisines. You can also find recipes for the food or find restaurants near you.




|Choose a Food|Find a Recipe|Find a restraunt|
|------|---|---|
|<img src="https://user-images.githubusercontent.com/48948578/120888344-caeb1300-c632-11eb-89fb-e738829885e7.gif"  width="200" height="350" align="left">|<p align="center"><img src="https://user-images.githubusercontent.com/48948578/120999566-3ca69680-c7c4-11eb-909c-2b455e6dd93e.gif"  width="200" height="350"></p>|<p align="center"><img src="https://user-images.githubusercontent.com/48948578/120999721-62cc3680-c7c4-11eb-96ea-8c913a477323.gif"  width="200" height="350"></p>|




# Contents
+ [Why?](#why)
+ [Installation](#Installation)
+ [Usage](#Usage)
+ [How FoodChooser is made](#How-FoodChooser-is-made)
+ [Fixes](#Fixes)

***
### Why?

I wanted an app that allows you to:
+ Make choice between random food.
+ Find near by restaurants of selected menu.
+ Find a recipe for selected menu and make it by yourself.

So that by using this app people will save time from browsing these information separately.

***
### Installation

1. Install the project.
> + Clone the project.    https://github.com/yleer/FoodChooser.git 
> + Or download the zip file.
2. Create a new scheme name same as 'FoodChooser'
3. Get API keys for :
> + Recipe - Food - Nutrition API.   https://rapidapi.com/marketplace
> + Kakao Map API.   https://apis.map.kakao.com/
4. Copy and paste your Api keys to the project's Constant.swift file.

***
### Usage
The primary purpose of this project is to help people choose what to eat for a meal. Many people today have diffuculty choosing what to eat everyday. If you are in this case, open FoodChoose App. This app will show random food images one by one on the screen. If you dont like the food on the screen, simply swipe the finger to left. Then new menu will appear. Keep doing this until you find the menu you want to eat. After you decide the menu, you can either find nearby restranut or find recipes for the menu. If choose to eat in the restranut, just click the button that says find restraunt. Button will lead you to map, which shows your current position in the map and near by restraunts information. If you choose to make food by your self, click the see the recipe button and it will lead you to variety of recipes for the menu. Next select the recipe you want to make, and recipe site will be show.



***
### How FoodChooser is made
1. Data Structure
 + FoodData - Store data for menu selection. Array of struct of Food. 
 >+ Food 
 >>+ English name
 >>+ Korean name
 >>+ image name
 
 
 + FoodRecipe - Result of Recipe Food Nutrition API. Contains information about recipes of certain menu.
 >+ Result
 >>+ title
 >>+ sourceUrl
 >>+ readyInMinutes
 >>+ image
 
 
 + DaumSearchData - Result of Kakao Map API. Contains information about near by restaurant of user.
 >+ PlaceInfo
 >>+ place_name
 >>+ address_name
 >>+ phone
 >>+ x
 >>+ y

 
2. APIs
 + Recipe Food Nutrition API - When user selects a menu, menu's name will be sent to the Recipe Food Nutrition API's end point. Then, Api retruns recipes for the menu.
 + Kakao Map API - When user selects a menu, Kakao Map Api will search the menu in Kakao Map near where you are. Providing restruant information.
3. UI 
 + Image Swiping - Showing one image at a time, making user concentrate to only one menu at a time. If like the menu user will select button to proceed. If do not like the menu, user will swipe the screen to see the next random food.
 
4. Data Flow 
 + Food Recipe Flow
  > 1) Food Data - Menu is chosen by the user. Menu's information is passed to Recipe Food Nutrition API.
  > 2) FoodRecipe - Recipe Food Nutrition API returns recipes for the menu. 
  > 3) sourceUrl - Url is used to show the recipe site.
  
 + Map Flow
  > 1) Food Data - Menu is chosen by the user. Menu's information is passed to Kakao Map API.
  > 2) DaumSearchData - Kakao Map Api returns restaurants' information.
  > 3) Using DaumSearchData marks locations of restaurant and your current location. 
  > 
### Fixes
+ Recipe TableView loading problem.
+ Recipe Browser problem.
 
 
 <pre>
 <code>
  private func fetchImage() {
        if let url = thumnailUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        if let imag = UIImage(data: imageData){
                            self?.foodThumNail.image = imag
                        }else{
                            print("no image available")
                        }
                    }
                }
            }
        }
    }
    
    var thumnailUrl : URL?{
        didSet {
            if thumnailUrl != nil && (oldValue != thumnailUrl) {
                fetchImage()
            }
        }
    }
    
    cell.thumnailUrl = URL(string: imageBaseUrl + decodedData!.results[indexPath.row].image)
 </code>
 </pre>
    
        
    <pre><code>let url = URL(string: imageBaseUrl + decodedData!.results[indexPath.row].image)
        let data = try! Data(contentsOf: url!)
        cell.foodThumNail.image = UIImage(data: data)</code></pre>

        
        

 

