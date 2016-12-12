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

    @IBOutlet weak var Username: UITextField!
    
    @IBAction func btnSend_Tap(_ sender: UIButton) {
        let url = "http://localhost:3000/task"
        
        let params: Parameters = [
            "Username" : Username.text!
        ]
        
        Alamofire.request(url , method: .post, parameters: params, encoding: JSONEncoding.default).responseString { response in
            debugPrint(response)
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

