//
//  FoodData.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/19.
//

import Foundation

struct FoodData {
    var foods : [Food] = []
    
    init() {
        foods.append(Food(name: "ramen", image: UIImage(named: "라멘.jpg")))
        foods.append(Food(name: "hamburger", image: UIImage(named: "햄버거.jpg")))
        foods.append(Food(name: "pizza", image: UIImage(named: "피자.jpg")))
        foods.append(Food(name: "curry", image: UIImage(named: "카레.jpg")))
        foods.append(Food(name: "budae jjigae", image: UIImage(named: "부대찌개.jpg")))
        foods.append(Food(name: "susi", image: UIImage(named: "스시.jpg")))
        foods.append(Food(name: "Sashimi", image: UIImage(named: "사시미.jpg")))
        foods.append(Food(name: "chicken", image: UIImage(named: "치킨.jpg")))
        foods.append(Food(name: "gopchang", image: UIImage(named: "곱창.jpg")))
        foods.append(Food(name: "bunsik", image: UIImage(named: "분식.jpg")))
    }
    
    struct Food{
        let name: String
        let image : UIImage?
    }

}

