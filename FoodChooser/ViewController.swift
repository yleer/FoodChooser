//
//  ViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/11.
//

import UIKit
import NMapsMap
 
class ViewController: UIViewController , UITextFieldDelegate, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        textfield.delegate = self
        
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
            destinationVC.searchString = textfield.text
            if let coordinate = locationManager.location?.coordinate{
                destinationVC.latitudeDobule = coordinate.latitude
                destinationVC.longitudeDouble = coordinate.longitude
            }
        }else{
            let destinationVC = segue.destination as! RecipeTableViewController
            destinationVC.searchString = textfield.text
        }
    }

    
    // MARK: text filed.
    @IBOutlet weak var textfield: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textfield.text!)
    }
}
