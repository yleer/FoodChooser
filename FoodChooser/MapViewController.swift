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
        "Authorization" : Constants.kakaoAuth,
    ]
    // url 처리 함수
    func urlRequest(){
        let query = "query=" + searchString! + "&y=" + String(latitudeDobule!) + "&x=" + String(longitudeDouble!) + "&radius=10000"
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
                        DispatchQueue.main.async {
                            self.kakaoMap(decodedData: decode)
                            print(decode)
                        }
                    }catch{
                        print("not good \(error )")
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .white
        // prepare로 부터 온게 nil 일수가 있네.
        
        urlRequest()
    }
    
    // 지도에 표시하는 함수
    private func kakaoMap(decodedData : DaumMapSearchData){
        let mapView = MTMapView(frame: view.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        
        
        var marks : [MTMapPOIItem] = []
        for place in decodedData.documents{
            let mark = MTMapPOIItem()
            
            mark.itemName = place.place_name
            
            mark.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double(place.y)!, longitude:Double(place.x)!))
            mark.markerType = .redPin
            mark.showAnimationType = .dropFromHeaven
            mark.draggable = false

            marks.append(mark)
            
            let info = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 90))
            info.backgroundColor = .gray

            let placeName = UITextView(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
            placeName.text = place.place_name
            let addressName = UITextView(frame: CGRect(x: 0, y: 30, width: 150, height: 30))
            addressName.text = place.address_name
            let phoneNumber = UITextView(frame: CGRect(x: 0, y: 60, width: 150, height: 30))
            phoneNumber.text = place.phone

            info.addSubview(placeName)
            info.addSubview(addressName)
            info.addSubview(phoneNumber)

            mark.customCalloutBalloonView = info

            mapView.addPOIItems(marks)
        }
        
        let currentMark = MTMapPOIItem()
        currentMark.itemName = "Current Location"
        currentMark.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: latitudeDobule!, longitude: longitudeDouble!))
        currentMark.markerType = .yellowPin
        currentMark.draggable = false
        currentMark.showAnimationType = .dropFromHeaven
        mapView.add(currentMark)
        
        // 지도 view main view에 추가.
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

//[
//    FoodChooser.PlaceInfo(place_name: "아구라멘비스트로 홍대직영점", address_name: "서울 마포구 서교동 332-1", phone: "02-336-9117", x: "126.926442312243", y: "37.55612730968"),
//    FoodChooser.PlaceInfo(place_name: "멘야산다이메 홍대점", address_name: "서울 마포구 서교동 355-25", phone: "02-332-4129", x: "126.921418812785", y: "37.5536760629849"),
//    FoodChooser.PlaceInfo(place_name: "멘야산다이메 연희점", address_name: "서울 서대문구 연희동 193-2", phone: "02-336-4129", x: "126.929447248228", y: "37.5655634793315")
//]
