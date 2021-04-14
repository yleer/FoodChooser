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
        
        let a = "pizza".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlString1 = "https://dapi.kakao.com/v2/local/search/keyword.json?query=" + a!
        
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
                       print(String(data: data!, encoding: .utf8))
                   }
               })
               dataTask.resume()
           }
   
       }
        
    
    
    private func kakaoMap(){
        let mapView = MTMapView(frame: view.frame)
        mapView.delegate = self
        mapView.baseMapType = .satellite
        view.addSubview(mapView)
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
    
//    private func showMap(){
//        let naverMapView = NMFNaverMapView(frame: view.frame)
//        naverMapView.showLocationButton = true
//        naverMapView.showCompass = true
//        view.addSubview(naverMapView)
//
//        // marker
//        let marker = NMFMarker()
//        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
//        marker.mapView = naverMapView.mapView
//
//        let marker2 = NMFMarker()
//        marker2.position = NMGLatLng(lat: 37.5070030, lng: 126.9783740)
//        marker2.mapView = naverMapView.mapView
//
//        // info
//        let infoWindow = NMFInfoWindow()
//        let dataSource = NMFInfoWindowDefaultTextSource.data()
//        dataSource.title = "정보 창 내용"
//        infoWindow.dataSource = dataSource
//        infoWindow.open(with: marker)
//
//    }
    
//    private func naverMap(){
//        let a = "햄버거".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//
//        if let url = URL(string: "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + a!)
//        {
//
//            let header = [
//                "X-NCP-APIGW-API-KEY-ID" : "phr26q14w5",
//                "X-NCP-APIGW-API-KEY" : "kAemBjTNtD7Wqdwq8OS57n1lyPcmekSVP6TvK5ON"
//            ]
//
//            let request = NSMutableURLRequest(
//                url: url,
//                cachePolicy: .useProtocolCachePolicy,
//                timeoutInterval: 10.0
//            )
//            request.httpMethod = "GET"
//            request.allHTTPHeaderFields = header
//
//
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//                if (error != nil) {
//                    print(error!)
//                }else {
//                    print(String(data: data!, encoding: .utf8))
//                }
//            })
//            dataTask.resume()
//        }
//
//    }




//{
//
//    "status\":\"OK\",
//    \"meta\":
//        {
//            \"totalCount\":1,
//            \"page\":1,
//            \"count\":1
//
//        },
//    \"addresses\":
//        [
//            {
//                \"roadAddress\":\"서울특별시 서초구 잠원동\",
//                \"jibunAddress\":\"서울특별시 서초구 잠원동\",
//                \"englishAddress\":\"Jamwon-dong, Seocho-gu, Seoul, Republic of Korea\",
//                \"addressElements\":
//                [
//                    {
//                            \"types\":
//                                [
//                                    \"SIDO\"
//                                ],
//                            \"longName\":\"서울특별시\",
//                            \"shortName\":\"서울특별시\",
//                            \"code\":\"\"
//
//                    },
//                    {
//                            \"types\":[\"SIGUGUN\"],\"longName\":\"서초구\",\"shortName\":\"서초구\",\"code\":\"\"},
//    {\"types\":[\"DONGMYUN\"],\"longName\":\"잠원동\",\"shortName\":\"잠원동\",\"code\":\"\"},
//    {\"types\":[\"RI\"],\"longName\":\"\",\"shortName\":\"\",\"code\":\"\"},
//    {\"types\":[\"ROAD_NAME\"],\"longName\":\"\",\"shortName\":\"\",\"code\":\"\"},
//                    {
//                            \"types\":[\"BUILDING_NUMBER\"],\"longName\":\"\",\"shortName\":\"\",\"code\":\"\"},
//    {\"types\":[\"BUILDING_NAME\"],\"longName\":\"\",\"shortName\":\"\",\"code\":\"\"},
//    {\"types\":[\"LAND_NUMBER\"],\"longName\":\"\",\"shortName\":\"\",\"code\":\"\"},
//    {\"types\":[\"POSTAL_CODE\"],\"longName\":\"\",\"shortName\":\"\",\"code\":\"\"}],\"x\":\"127.0142194\",\"y\":\"37.5149511\",\"distance\":0.0
//
//                    }
//            ],
//
//
//
//    \"errorMessage\":\"\"
//
//
//
//
//
//}

//https://fomaios.tistory.com/entry/iOS-네이버-API를-이용해서-주소를-위도경도로-변환하기NAVER-CLOUD-PLATFORM-GEOCODING  참고
