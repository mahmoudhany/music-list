//
//  secondViewController.swift
//  music album
//
//  Created by Mahmoud on 5/11/17.
//  Copyright © 2017 Mahmoud. All rights reserved.
//

import UIKit


class secondViewController: UIViewController {
    
    
//    var activeRow:Int?
    
    @IBOutlet weak var webView: UIWebView!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
    
    @IBOutlet weak var label: UILabel!
    var itemUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if itemUrl != nil {
            
            let url = URL(string: itemUrl!)
            
            let urlRequest = URLRequest(url: url!)
            
            webView.loadRequest(urlRequest)            
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
      
        
    }

    

}
