//
//  ViewController.swift
//  APIKitSample
//
//  Created by 水野祥子 on 2017/08/05.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView()
        webView.frame = self.view.frame
        self.view.addSubview(webView)
        
        let sampleURL = NSURL(string: "https://www.google.co.jp/")
        let urlRequest = NSURLRequest(url: sampleURL as! URL)
        webView.loadRequest(urlRequest as URLRequest)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

