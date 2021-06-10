//
//  RecipeBrowserViewController.swift
//  FoodChooser
//
//  Created by Yundong Lee on 2021/04/23.
//

import UIKit
import WebKit

class RecipeBrowserViewController: UIViewController, WKNavigationDelegate {
    
    var recipeUrl : String?
    var recipeName : String?
    var webView = WKWebView()
    
    
    private func setUpNavBar(){
        self.title = recipeName!
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        view.addSubview(webView)
        if recipeUrl![recipeUrl!.index(recipeUrl!.startIndex, offsetBy: 4)] != "s"{
            recipeUrl!.insert("s", at: recipeUrl!.index(recipeUrl!.startIndex, offsetBy: 4))
        }
        
        
        
        let url = URL(string: recipeUrl!)!
        print(url)
        webView.load(URLRequest(url: url))
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
