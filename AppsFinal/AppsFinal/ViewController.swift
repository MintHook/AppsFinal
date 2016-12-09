//
//  ViewController.swift
//  AppsFinal
//
//  Created by SpencerWagner on 12/6/16.
//  Copyright © 2016 SpencerWagner. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class ViewController: UIViewController {
    var Update: Timer?
    
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var message: UITextField!
    
    @IBAction func Update(_ sender: AnyObject) {
        let url = "http://localhost:3000/texts"
        
        let params: Parameters = [
            "Username" : Username.text!,
            "message" : message.text!
        ]
        
        Alamofire.request(url , method: .post, parameters: params, encoding: JSONEncoding.default).responseString { response in
            debugPrint(response)
        }
        
        Update = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.getButton), userInfo: nil, repeats: true)
    }
    
    func getButton(){
        let geturl = "http://localhost:3000/texts"
        
        Alamofire.request(geturl , method: .get, encoding: JSONEncoding(options: [])).responseJSON { response in
            debugPrint(response)
            
            if let result = response.result.value {
                let json = JSON(result as! NSDictionary)
                let text = json["data"].arrayValue
                
                // display only the last task
                let subject = texts[texts.count - 1]["Username"].string
                let description = texts[texts.count - 1]["message"].string
                self.lblSubject.text = Username
                self.lblDescription.text = message
                
            } else {
                nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

