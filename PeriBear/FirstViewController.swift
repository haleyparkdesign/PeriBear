//
//  FirstViewController.swift
//  PeriBear
//
//  Created by Hyojeong Park on 23/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    let onColor  = _your_on_state_color
    let offColor = _your_off_state_color
    
    let mSwitch = UISwitch(frame: CGRectZero)
    mSwitch.on = true
    
    /*For on state*/
    mSwitch.onTintColor = onColor
    
    /*For off state*/
    mSwitch.tintColor = offColor
    mSwitch.layer.cornerRadius = mSwitch.frame.height / 2
    mSwitch.backgroundColor = offColor
}

