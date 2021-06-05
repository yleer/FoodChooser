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
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        self.navigationController?.navigationBar.barTintColor = .white
        recipeUrl!.insert("s", at: recipeUrl!.index(recipeUrl!.startIndex, offsetBy: 4))
        
        let url = URL(string: recipeUrl!)!
        print(url)
        webView.load(URLRequest(url: url))
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
