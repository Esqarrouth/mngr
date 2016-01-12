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
import ActionButton
import QorumLogs
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

        
        

        //users.json
        //tasks.json
        //tasks.json?userid=
        ez.requestJSON("https://mngr-api.herokuapp.com/tasks.json", success: { (object) -> Void in
            let json = JSON(object!)
            
            var myTasks = [Tasks]()

            var counter = 0
            for subj in json {
                let myTask = Tasks(text: json[counter]["body"].stringValue, completed: json[counter]["completed"].boolValue, level: json[counter]["priority"].intValue, assignedTo: "")
                
                myTasks.append(myTask)
                
                counter++
            }
            
            ez.runThisInMainThread({ () -> Void in
                self.createViews(myTasks)
            })

            QL2(object)
            
            }) { (error) -> Void in
                
             QL4("some type of error")
        }
        

        
        let myButton = BlockButton(x: ez.screenWidth - 50, y: ez.screenHeight - 50, w: 30, h: 30) { (sender) -> Void in

//            ez.requestJSON("https://mngr-api.herokuapp.com/tasks.json?body=mybody&completed=false&priority=2", success: { (object) -> Void in
//                QL2(555)
//                
//                
//                }, error: { (error) -> Void in
//                    
//                  QL4("error")
//            })

            
            let request = NSMutableURLRequest(URL: NSURL(string: "https://mngr-api.herokuapp.com/tasks.json")!)
            request.HTTPMethod = "POST"
            let postString = "task[user_id]=1&task[body]=mybody&task[completed]=false&task[priority]=2"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                guard error == nil && data != nil else {                                                          // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("responseString = \(responseString)")
            }
            task.resume()

        
        }
        myButton.backgroundColor = UIColor.redColor()
        view.addSubview(myButton)
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




