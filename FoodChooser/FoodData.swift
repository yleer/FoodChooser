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
        foods.append(Food(englishName: "ramen", image: UIImage(named: "라멘.jpg"),koreanName: "라면"))
        foods.append(Food(englishName: "hamburguer", image: UIImage(named: "햄버거.jpg"),koreanName: "햄버거"))
        foods.append(Food(englishName: "pizza", image: UIImage(named: "피자.jpg"),koreanName: "피자"))
        foods.append(Food(englishName: "curry", image: UIImage(named: "카레.jpg"),koreanName: "카레"))
        foods.append(Food(englishName: "budae jjigae", image: UIImage(named: "부대찌개.jpg"),koreanName: "부대찌게"))
        foods.append(Food(englishName: "susi", image: UIImage(named: "스시.jpg"),koreanName: "스시"))
        foods.append(Food(englishName: "Sashimi", image: UIImage(named: "사시미.jpg"),koreanName: "사시미"))
        foods.append(Food(englishName: "chicken", image: UIImage(named: "치킨.jpg"),koreanName: "치킨"))
        foods.append(Food(englishName: "gopchang", image: UIImage(named: "곱창.jpg"),koreanName: "곱창"))
        foods.append(Food(englishName: "bunsik", image: UIImage(named: "분식.jpg"),koreanName: "분식"))
    }
    
    struct Food{
        let englishName: String
        let image : UIImage?
        let koreanName : String
    }

}

