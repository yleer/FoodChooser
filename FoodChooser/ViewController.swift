//
//  ViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/11.
//



// 고쳐야 할 것들.
// 지도 문제 좀 있네.
// 전체 디자인



import UIKit
import NMapsMap

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var baseView: UIView!
    @IBOutlet var foodImageView: UIImageView!
    
    let locationManager = CLLocationManager()  // location service
    let foodData = FoodData()
    
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
    
    override func viewDidLoad() {
        foodImageView.image = foodData.foods[currentIndexPath].image
        baseViewFrame = baseView.frame
        
        // getting current location.
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
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
            destinationVC.searchString = foodData.foods[currentIndexPath].name
            if let coordinate = locationManager.location?.coordinate{
                destinationVC.latitudeDobule = 37.5575
                //                    coordinate.latitude
                destinationVC.longitudeDouble = 126.9245
//                coordinate.longitude
            //                37.5575
            //                126.9245
            }
        // segue to recipe
        }else{
            let destinationVC = segue.destination as! RecipeTableViewController
            destinationVC.searchString = foodData.foods[currentIndexPath].name
        }
    }
}
