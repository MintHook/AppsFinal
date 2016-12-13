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
    var Username: String?
    @IBOutlet weak var Welcome: UITextView!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var UITextView: UITextView!
    
    @IBAction func Update(_ sender: AnyObject) {
        let url = "http://10.10.90.104:3000/texts"
        
        let params: Parameters = [
            "message" : message.text!,
        ]
        
        Alamofire.request(url , method: .post, parameters: params, encoding: JSONEncoding.default).responseString { response in
            debugPrint(response)
        }
        
        Update = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MessageViewController.getButton), userInfo: nil, repeats: false)
    }
    
    func getButton(){
        let geturl = "http://10.10.90.104:3000/texts"
        
        Alamofire.request(geturl , method: .get, encoding: JSONEncoding(options: [])).responseJSON { response in
            debugPrint(response)
            
            if let result = response.result.value {
                let json = JSON(result as! NSDictionary)
                let text = json["data"].arrayValue
                
                // display only the last task
                let message = text[text.count - 1]["message"].string
                self.UITextView.text = "\(self.Username): \(message)"
            } else {
                self.UITextView.text = ""
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Welcome.text = "Welcome " + Username! + "."
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
