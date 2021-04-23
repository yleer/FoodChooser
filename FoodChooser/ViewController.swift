//
//  ViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/11.
//

import UIKit
import NMapsMap
 
class ViewController: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet var pp: UIView!
    let locationManager = CLLocationManager()
    let foodData = FoodData()

    
    @IBOutlet var imageView: UIImageView!
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: card)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)

        if sender.state == UIPanGestureRecognizer.State.ended{
            if card.center.x < 75{
                currentIndexPath += 1
                UIView.animate(
                    withDuration: 0.3,
                    animations: {
                        card.center = CGPoint(x: card.center.x - 200, y: card.center.y)
                        card.alpha = 0
                    },
                    completion: { finished in
                        self.imageView.image = self.foodData.foods[self.currentIndexPath].image
                        card.frame = self.ppFrame!
                        UIView.animate(withDuration: 0.3, animations: {
                            card.alpha = 1
                        })
                    }
                )
                return
            }else if card.center.x > (view.frame.width - 75){
                currentIndexPath -= 1
                UIView.animate(
                    withDuration: 0.3,
                    animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y)
                    card.alpha = 0
                    },
                    completion: { finished in
                        card.frame = self.ppFrame!
                        self.imageView.image = self.foodData.foods[self.currentIndexPath].image
                        UIView.animate(withDuration: 0.3, animations: {
                            card.alpha = 1
                        })
                    }
                )
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                card.frame = self.ppFrame!
            })
        }
        
    }
    
    var ppFrame : CGRect?
    override func viewDidLoad() {
        imageView.image = foodData.foods[currentIndexPath].image
        ppFrame = pp.frame
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    var currentIndexPath = 0
        
    // MARK: Segue.
    @IBAction func mapButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue to map", sender: self)
    }
    
    @IBAction func recipeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue to recipe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segue to map"{
            let destinationVC = segue.destination as! MapViewController
            destinationVC.searchString = foodData.foods[currentIndexPath].name
            if let coordinate = locationManager.location?.coordinate{
                destinationVC.latitudeDobule = 37.5575
//                    coordinate.latitude
                destinationVC.longitudeDouble = 126.9245
                    coordinate.longitude
//                37.5575
//                126.9245
            }
        }else{
            let destinationVC = segue.destination as! RecipeTableViewController
            destinationVC.searchString = foodData.foods[currentIndexPath].name
        }
    }

}
