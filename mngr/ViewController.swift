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
import SwiftRandom

var userName = ""

struct Tasks {
    var text: String
    var completed: Bool
    var level: Int
    var assignedTo: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testTask = Tasks(text: "text of task", completed: false, level: 1, assignedTo: "me")
        let testTask2 = Tasks(text: "text of tas2k", completed: false, level: 3, assignedTo: "me")

        
        createViews([testTask, testTask2])

        //users.json
        //tasks.json
        //tasks.json?userid=
        ez.requestJSON("https://mngr-api.herokuapp.com/users.json", success: { (object) -> Void in
            print(object)
            
//            [{"id":1,"name":"Brian","manager_id":3,"created_at":"2016-01-12T04:42:47.728Z","updated_at":"2016-01-12T04:42:47.728Z"},{"id":2,"name":"Goktug","manager_id":3,"created_at":"2016-01-12T04:43:02.075Z","updated_at":"2016-01-12T04:43:02.075Z"},{"id":3,"name":"Boss","manager_id":null,"created_at":"2016-01-12T04:43:10.994Z","updated_at":"2016-01-12T04:43:52.749Z"}]
            
            }) { (error) -> Void in
                
                
        }
        
        
    }
    
    func createViews(taskList: [Tasks]) {
        var nowY: CGFloat = ez.screenStatusBarHeight
        
        for task in taskList {
            let aview = UIView(x: 0, y: nowY, w: ez.screenWidth, h: 50)
            aview.backgroundColor = UIColor.random()
            view.addSubview(aview)
            
            let label = UILabel(x: 10, y: 0, w: 50, h: 50, fontSize: 17)
            label.text = task.level.toString
            aview.addSubview(label)
            
            let text = UITextView(x: 50, y: 0, w: ez.screenWidth - 50, h: 50, fontSize: 17)
            text.text = task.text
            aview.addSubview(text)
            
            nowY += aview.h
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




