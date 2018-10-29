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

    func lineDraw(viewLi:UIView) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: viewLi.frame.size.height - width, width:  viewLi.frame.size.width, height: viewLi.frame.size.height)
        border.borderWidth = width
        viewLi.layer.addSublayer(border)
        viewLi.layer.masksToBounds = true
    }
}

