//
//  ReciepeTableViewCell.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/06/01.
//

import UIKit

class ReciepeTableViewCell: UITableViewCell {

    @IBOutlet var baseView: UIView!
    @IBOutlet var foodThumNail: UIImageView!
    @IBOutlet var foodTitle: UILabel!
    @IBOutlet var foodDuration: UILabel!
    
    
    var thumnailUrl : URL?{
        didSet {
            if thumnailUrl != nil && (oldValue != thumnailUrl) {
                fetchImage()
            }
        }
    }
    
    
    private func fetchImage() {
        if let url = thumnailUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        if let imag = UIImage(data: imageData){
                            self?.foodThumNail.image = imag
                        }else{
                            print("no image available")
                        }
                    }
                }
            }
        }
    }
    
}
