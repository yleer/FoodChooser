//
//  ViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/11.
//



// 고쳐야 할 것들.
// 핸드폰으로 실행 했을때 실제로 현재 위치 가져올 수 있나 확인하기.
// 지도에서 마커 눌렀을때 나오는 view 디자인 조금 하기
// 전체 코드 정리.



import UIKit
import CoreLocation

class MainViewControlelr: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var baseView: UIView!
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var buyFood: UIButton!
    @IBOutlet var makeFood: UIButton!
    
    
    let locationManager = CLLocationManager()  // location service
    var foodData = FoodData()
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: card)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if sender.state == UIPanGestureRecognizer.State.ended{
            if card.center.x < 75{
                if currentIndexPath < foodData.foods.count - 1{
                    currentIndexPath += 1
                    UIView.animate(
                        withDuration: 0.3,
                        animations: {
                            card.center = CGPoint(x: card.center.x - 200, y: card.center.y)
                            card.alpha = 0
                        },
                        completion: { finished in
                            self.foodImageView.image = self.foodData.foods[self.currentIndexPath].image
                            self.titleLabel.text = self.foodData.foods[self.currentIndexPath].koreanName + " " + "먹을까?"
                            self.makeFood.setTitle(self.foodData.foods[self.currentIndexPath].koreanName + " " + "만들어 먹자.", for: .normal)
                            self.buyFood.setTitle(self.foodData.foods[self.currentIndexPath].koreanName + " " + "근처 맛집 어디?", for: .normal)
                            card.frame = self.baseViewFrame!
                            UIView.animate(withDuration: 0.3, animations: {
                                card.alpha = 1
                            })
                        }
                    )
                    return
                }
                
            }else if card.center.x > (view.frame.width - 75){
                if currentIndexPath > 0{
                    currentIndexPath -= 1
                    
                    UIView.animate(
                        withDuration: 0.3,
                        animations: {
                            card.center = CGPoint(x: card.center.x + 200, y: card.center.y)
                            card.alpha = 0
                        },
                        completion: { finished in
                            card.frame = self.baseViewFrame!
                            self.foodImageView.image = self.foodData.foods[self.currentIndexPath].image
                            self.titleLabel.text = self.foodData.foods[self.currentIndexPath].koreanName + " " + "먹을까?"
                            self.makeFood.setTitle(self.foodData.foods[self.currentIndexPath].koreanName + " " + "만들어 먹자.", for: .normal)
                            self.buyFood.setTitle(self.foodData.foods[self.currentIndexPath].koreanName + " " + "근처 맛집 어디?", for: .normal)
                            UIView.animate(withDuration: 0.3, animations: {
                                card.alpha = 1
                            })
                        }
                    )
                    return
                }
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                card.frame = self.baseViewFrame!
            })
        }
    }
    
    var baseViewFrame : CGRect?
    var currentIndexPath = 0
    
    private func setUpViews(){
        self.title = "Food Chooser"
        titleLabel.text = foodData.foods[currentIndexPath].koreanName + " " + "먹을까?"
        foodImageView.image = foodData.foods[currentIndexPath].image
        makeFood.setTitle(foodData.foods[currentIndexPath].koreanName + " " + "만들어 먹자.", for: .normal)
        buyFood.setTitle(foodData.foods[currentIndexPath].koreanName + " " + "근처 맛집 어디?", for: .normal)
        baseViewFrame = baseView.frame
        foodImageView.layer.cornerRadius = Constants.cornerRadius
        makeFood.layer.cornerRadius = Constants.cornerRadius
        buyFood.layer.cornerRadius = Constants.cornerRadius
        navigationController?.navigationBar.barTintColor = Constants.mainNavBarColor
    }
    
    override func viewDidLoad() {
        setUpViews()
        
        // getting current location.
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = Constants.mainNavBarColor
    }
    
    
    // MARK: Segue.
    @IBAction func mapButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue to map", sender: self)
    }
    
    @IBAction func recipeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue to recipe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue to map
        if segue.identifier == "segue to map"{
            let destinationVC = segue.destination as! MapViewController
            destinationVC.searchString = foodData.foods[currentIndexPath].koreanName
            if let coordinate = locationManager.location?.coordinate{
                print(coordinate)
                // 우선 홍대 좌표로 설정함.
//                destinationVC.latitudeDobule = 37.5575
//                destinationVC.longitudeDouble = 126.9245
                
                destinationVC.latitudeDobule = coordinate.latitude
                destinationVC.longitudeDouble = coordinate.longitude
                destinationVC.menu = foodData.foods[currentIndexPath].koreanName
                
            }
            // segue to recipe
        }else{
            let destinationVC = segue.destination as! RecipeTableViewController
            destinationVC.searchString = foodData.foods[currentIndexPath].englishName
        }
    }
}
