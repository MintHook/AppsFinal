//
//  MessageViewController.swift
//  AppsFinal
//
//  Created by SpencerWagner on 12/12/16.
//  Copyright © 2016 SpencerWagner. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MessageViewController: UIViewController {
    var Update: Timer?
    
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var UITextView: UITextView!
    
    
    @IBAction func Update(_ sender: AnyObject) {
        let url = "http://localhost:3000/texts"
        
        let params: Parameters = [
            "message" : message.text!
        ]
        
        Alamofire.request(url , method: .post, parameters: params, encoding: JSONEncoding.default).responseString { response in
            debugPrint(response)
        }
        
        Update = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MessageViewController.getButton), userInfo: nil, repeats: true)
    }
    
    func getButton(){
        let geturl = "http://localhost:3000/texts"
        
        Alamofire.request(geturl , method: .get, encoding: JSONEncoding(options: [])).responseJSON { response in
            debugPrint(response)
            
            if let result = response.result.value {
                let json = JSON(result as! NSDictionary)
                let text = json["data"].arrayValue
                
                // display only the last task
                let person = text[text.count - 1]["Username"].string
                let message = text[text.count - 1]["message"].string
                self.UITextView.text = "\(person): \(message)"
                
            } else {
                self.UITextView.text = "/(person) said nothing."
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UITextView.text = "Welcome!"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
