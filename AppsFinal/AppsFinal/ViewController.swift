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
        let url = "http://10.10.90.104:3000/texts"
        
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

    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        let second = segue.destination as! MessageViewController
        second.Username = Username.text
    }
}

