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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodData.foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "food image cell", for: indexPath) as! FoodImageCollectionViewCell
        cell.foodImage.image = foodData.foods[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
       }

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
//            destinationVC.searchString = textfield.text
            if let coordinate = locationManager.location?.coordinate{
                destinationVC.latitudeDobule = coordinate.latitude
                destinationVC.longitudeDouble = coordinate.longitude
            }
        }else{
            let destinationVC = segue.destination as! RecipeTableViewController
//            destinationVC.searchString = textfield.text
        }
    }

    }
