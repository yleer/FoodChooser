//
//  JunkFunctions.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/14.
//

import Foundation

// MARK: naver map ex
//private func naverMap(){
//    let a = "햄버거".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//
//    if let url = URL(string: "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + a!)
//    {
//
//        let header = [
//            "X-NCP-APIGW-API-KEY-ID" : "phr26q14w5",
//            "X-NCP-APIGW-API-KEY" : "kAemBjTNtD7Wqdwq8OS57n1lyPcmekSVP6TvK5ON"
//        ]
//
//        let request = NSMutableURLRequest(
//            url: url,
//            cachePolicy: .useProtocolCachePolicy,
//            timeoutInterval: 10.0
//        )
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = header
//
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error!)
//            }else {
//                print(String(data: data!, encoding: .utf8))
//            }
//        })
//        dataTask.resume()
//    }
//
//}

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




// MARK: kako map data ex
//{
//    \"documents\":
//                    [
//                        {
//                            \"address_name\":\"서울 서대문구 홍은동 48-181\",
//                            \"category_group_code\":\"FD6\",
//                            \"category_group_name\":\"음식점\",
//                            \"category_name\":\"음식점 \\u003e 양식 \\u003e 피자\",
//                            \"distance\":\"\",
//                            \"id\":\"913584082\",
//                            \"phone\":\"02-358-5522\",
//                            \"place_name\":\"PIZZA D\",
//                            \"place_url\":\"http://place.map.kakao.com/913584082\",
//                            \"road_address_name\":\"서울 서대문구 세검정로 9\",
//                            \"x\":\"126.942433403904\",
//                            \"y\":\"37.5920020842759\"
//
//                        },
//                        {
//                            \"address_name\":\"서울 강남구 역삼동 620-17\",
//                            \"category_group_code\":\"FD6\",
//                            \"category_group_name\":\"음식점\",
//                            \"category_name\":\"음식점 \\u003e 양식 \\u003e 피자\",
//                            \"distance\":\"\",\"id\":\"14585892\",
//                            \"phone\":\"02-556-8001\",
//                            \"place_name\":\"도치피자 강남점\",
//                            \"place_url\":\"http://place.map.kakao.com/14585892\",\"road_address_name\":\"서울 강남구 강남대로98길 27\",
//                            \"x\":\"127.028883471736\",
//                            \"y\":\"37.5009936710604\"
//
//                        }
//                    ],
//    \"meta\":
//        {
//            \"is_end\":false,
//            \"pageable_count\":45,
//            \"same_name\":
//                    {
//                        \"keyword\":\"pizza\",
//                        \"region\":[],
//                        \"selected_region\":\"\"
//
//                    },
//            \"total_count\":3982
//
//        }
//
//}

