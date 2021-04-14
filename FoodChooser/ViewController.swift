//
//  ViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/11.
//

import UIKit
import NMapsMap
 
class ViewController: UIViewController , UITextFieldDelegate, MTMapViewDelegate{
    
    override func viewDidLoad() {
        textfield.delegate = self
        
        let a = "query=pizza&y=37.4978&x=127.0037&radius=30000".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlString1 = "https://dapi.kakao.com/v2/local/search/keyword.json?" + a!
        
        if let url = URL(string: urlString1)
           {
               let header = [
                "Authorization" : "KakaoAK 6a64b9ddab928a9caf16271ed0de0b9a",
               ]
               let request = NSMutableURLRequest(
                   url: url,
                   cachePolicy: .useProtocolCachePolicy,
                   timeoutInterval: 10.0
               )
               request.httpMethod = "GET"
               request.allHTTPHeaderFields = header


               let session = URLSession.shared
               let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                   if (error != nil) {
                       print(error!)
                   }else {
                    let decoder = JSONDecoder()
                    do{
                        let decode = try decoder.decode(DaumMapSearchData.self, from: data!)
//                        print(decode.documents.first)
                        for place in decode.documents{
                            print(place.place_name)
                        }
                    }catch{ error
                        print("not good \(error )")
                    }
                   }
               })
               dataTask.resume()
           }
        
        
        
        
        kakaoMap()
       }
        
    
    
    private func kakaoMap(){
        let mapView = MTMapView(frame: view.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard

        
        // Marker
        let mark = MTMapPOIItem()
        mark.itemName = "test"
        mark.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.5920020842759, longitude: 126.942433403904))
        mark.markerType = .bluePin
        mark.showAnimationType = .dropFromHeaven
        mark.draggable = true
        mark.tag = 12
        
        mapView.addPOIItems([mark])
        
        
        view.addSubview(mapView)
        
        // 위치 현제 coord 찾아서 대입만 하자.
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.4978, longitude: 127.0037)), zoomLevel: MTMapZoomLevel(2), animated: true)
        
        
        
        
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


//place_name: "PIZZA D",
//address_name: "서울 서대문구 홍은동 48-181",
//phone: "02-358-5522",
//x: "126.942433403904",
//y: "37.5920020842759"


//not good keyNotFound(CodingKeys(stringValue: "documents", intValue: nil), Swift.DecodingError.Context(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"documents\", intValue: nil) (\"documents\").", underlyingError: nil))
