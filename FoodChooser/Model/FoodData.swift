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
        foods.append(Food(englishName: "Ramen", image: UIImage(named: "라멘.jpg"),koreanName: "라면"))
        foods.append(Food(englishName: "Hamburguer", image: UIImage(named: "햄버거.jpg"),koreanName: "햄버거"))
        foods.append(Food(englishName: "Pizza", image: UIImage(named: "피자.jpg"),koreanName: "피자"))
        foods.append(Food(englishName: "Curry", image: UIImage(named: "카레.jpg"),koreanName: "카레"))
        foods.append(Food(englishName: "Budae jjigae", image: UIImage(named: "부대찌개.jpg"),koreanName: "부대찌게"))
        foods.append(Food(englishName: "Susi", image: UIImage(named: "스시.jpg"),koreanName: "스시"))
        foods.append(Food(englishName: "Sashimi", image: UIImage(named: "사시미.jpg"),koreanName: "사시미"))
        foods.append(Food(englishName: "Chicken", image: UIImage(named: "치킨.jpg"),koreanName: "치킨"))
        foods.append(Food(englishName: "Gopchang", image: UIImage(named: "곱창.jpg"),koreanName: "곱창"))
        foods.append(Food(englishName: "Bunsik", image: UIImage(named: "분식.jpg"),koreanName: "분식"))
        foods.shuffle()
    }
    
    struct Food{
        let englishName: String
        let image : UIImage?
        let koreanName : String
    }

}

