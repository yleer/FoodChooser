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
        foods.append(Food(name: "라멘", image: UIImage(named: "라멘.jpg")))
        foods.append(Food(name: "곱창", image: UIImage(named: "곱창.jpg")))
        foods.append(Food(name: "분식", image: UIImage(named: "분식.jpg")))
        foods.append(Food(name: "햄버거", image: UIImage(named: "햄버거.jpg")))
        foods.append(Food(name: "피자", image: UIImage(named: "피자.jpg")))
        foods.append(Food(name: "카레", image: UIImage(named: "카레.jpg")))
        foods.append(Food(name: "부대찌개", image: UIImage(named: "부대찌개.jpg")))
        foods.append(Food(name: "쓰시", image: UIImage(named: "스시.jpg")))
        foods.append(Food(name: "사시미", image: UIImage(named: "사시미.jpg")))
        foods.append(Food(name: "치킨", image: UIImage(named: "치킨.jpg")))
    }
    
    struct Food{
        let name: String
        let image : UIImage?
    }

}

