//
//  ViewController.swift
//  mngr
//
//  Created by Goktug Yilmaz on 1/11/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ez.requestJSON("asd", success: { (object) -> Void in
            
            
            }) { (error) -> Void in
                
                
        }
        
        
    }
    
    func createViews() {
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

