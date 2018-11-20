//
//  FourthViewController.swift
//  PeriBear
//
//  Created by Hyojeong Park on 31/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import UIKit
import UserNotifications

class FourthViewController: UIViewController {
    
    @IBOutlet weak var startingDaySwitch: UISwitch!
    
    @IBAction func startingDaySwitchChanged(_ sender: Any) {
        createNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Period Started"
        content.subtitle = "Subtitle"
        content.body = "Body"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {
            (error) in print(error as Any)
        }
    }
}
