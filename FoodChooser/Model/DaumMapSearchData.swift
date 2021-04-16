//
//  DaumMapSearchData.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/14.
//

import Foundation

// https://m.blog.naver.com/kiddwannabe/221812712712

struct DaumMapSearchData : Codable {
    let documents : [PlaceInfo]
}

struct PlaceInfo : Codable {
    let place_name : String
    let address_name: String
    let phone: String
    let x: String
    let y: String
}

