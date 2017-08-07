//
//  ViewController.swift
//  APIKitSample
//
//  Created by 水野祥子 on 2017/08/05.
//  Copyright © 2017年 sachiko. All rights reserved.
//

import UIKit
import APIKit

struct RateLimitRequest: Request {
    typealias Response = RateLimit
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/rate_limit"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> RateLimit {
        return try RateLimit(object: object)
    }
}

//レスポンスの型の定義、保持、ここから値取り出してのちにprintする
struct RateLimit {
    let limit: Int
    let remaining: Int
    
    init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
            let rateDictionary = dictionary["rate"] as? [String: Any],
            let limit = rateDictionary["limit"] as? Int,
            let remaining = rateDictionary["remaining"] as? Int else {
                throw ResponseError.unexpectedObject(object)
        }
        
        self.limit = limit
        self.remaining = remaining
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = RateLimitRequest()
        
        Session.send(request) { result in
            switch result {
            case .success(let rateLimit):
                // Type of `rateLimit` is inferred as `RateLimit`,
                // which is also known as `RateLimitRequest.Response`.
                print("limit: \(rateLimit.limit)")
                print("remaining: \(rateLimit.remaining)")
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
        
//        self.sampleWebView()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    func sampleWebView (){
//        let webView = UIWebView()
//        webView.frame = self.view.frame
//        self.view.addSubview(webView)
//        
//        let sampleURL = NSURL(string: "https://www.google.co.jp/")
//        let urlRequest = NSURLRequest(url: sampleURL as! URL)
//        webView.loadRequest(urlRequest as URLRequest)
//
//    }

}

