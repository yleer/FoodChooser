//
//  MapViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/16.
//

import UIKit
import CoreLocation

class MapViewController: UIViewController, MTMapViewDelegate {
    
    var searchString : String?
    var latitudeDobule : Double?
    var longitudeDouble : Double?
    
    let header = [
        "Authorization" : "KakaoAK 6a64b9ddab928a9caf16271ed0de0b9a",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 국립중앙도서관
//        latitudeDobule = 37.4978
//        longitudeDouble = 127.0037
        //홍대입구
         
        latitudeDobule = 37.5575
        longitudeDouble = 126.9245
        
        let query = "query=" + searchString! + "&y=" + String(latitudeDobule!) + "&x=" + String(longitudeDouble!) + "&radius=3000"
        let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json?" + query
        if let url = URL(string: urlString){
            
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
                        // print(decode.documents.first)
                        DispatchQueue.main.async {
                            self.kakaoMap(decodedData: decode)
                        }
                    }catch{ 
                        print("not good \(error )")
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    private func kakaoMap(decodedData : DaumMapSearchData){
        let mapView = MTMapView(frame: view.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        
        for place in decodedData.documents{
            let mark = MTMapPOIItem()
            mark.itemName = place.place_name
            mark.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double(place.y)!, longitude:Double(place.x)!))
            mark.markerType = .bluePin
            mark.showAnimationType = .dropFromHeaven
            mark.draggable = true
            mapView.addPOIItems([mark])
        }
        
        
        view.addSubview(mapView)
        
        // 위치 현제 coord 찾아서 대입만 하자.
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitudeDobule!, longitude: longitudeDouble!)), zoomLevel: MTMapZoomLevel(2), animated: true)
    }
    
}




//place_name: "PIZZA D",
//address_name: "서울 서대문구 홍은동 48-181",
//phone: "02-358-5522",
//x: "126.942433403904",
//y: "37.5920020842759"

//        let a = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ??
