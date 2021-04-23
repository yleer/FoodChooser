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
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        let url = URL(string: recipeUrl!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
