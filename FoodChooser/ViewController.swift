//
//  ViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/11.
//

import UIKit
import NMapsMap
 
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    let foodData = FoodData()

    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    var currentIndexPath : Int?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodData.foods.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "food image cell", for: indexPath) as! FoodImageCollectionViewCell
        cell.foodImage.image = foodData.foods[indexPath.row].image
        return cell
    }
    
    // MARK: Segue.
    @IBAction func mapButton(_ sender: UIButton) {
        for cell in collectionView.visibleCells{
            if let indexPath = collectionView.indexPath(for: cell){
                currentIndexPath = indexPath.row
                performSegue(withIdentifier: "segue to map", sender: self)
                break
            }
        }
    }
    
    @IBAction func recipeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue to recipe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue to map"{
            let destinationVC = segue.destination as! MapViewController
            destinationVC.searchString = foodData.foods[currentIndexPath!].name
            if let coordinate = locationManager.location?.coordinate{
                destinationVC.latitudeDobule = coordinate.latitude
                destinationVC.longitudeDouble = coordinate.longitude
            }
        }else{
            let destinationVC = segue.destination as! RecipeTableViewController
            destinationVC.searchString = foodData.foods[currentIndexPath!].name
        }
    }

}


// MARK: collection flow layout, delegate part.
extension ViewController{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(foodData.foods[indexPath.row].name)
    }
}
