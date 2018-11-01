//
//  SecondViewController.swift
//  PeriBear
//
//  Created by Hyojeong Park on 23/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import UIKit

var cycle = 28
var duaration = 5

class SecondViewController: UIViewController {
    @IBOutlet weak var cycleDays: UILabel!
    @IBOutlet weak var CycleHistoryBtn: UIButton!
    @IBOutlet weak var CalendarBtn: UIButton!
    @IBOutlet weak var TintedUnderline: UIView!
    
    // toggles between two views
    @IBAction func CalendarBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            self.TintedUnderline.frame.origin.x = UIScreen.main.bounds.width / 2
        }, completion: { finished in
        })
        
        CalendarBtn.titleLabel?.font =  UIFont(name: "ApercuPro-Bold", size: 18)
        CycleHistoryBtn.titleLabel?.font =  UIFont(name: "ApercuPro", size: 18)
    }
    @IBAction func CycleHistoryBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            self.TintedUnderline.frame.origin.x = 0
        }, completion: { finished in
        })
        
        CycleHistoryBtn.titleLabel?.font =  UIFont(name: "ApercuPro-Bold", size: 18)
        CalendarBtn.titleLabel?.font =  UIFont(name: "ApercuPro", size: 18)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension UIView {
    @IBInspectable
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIView {
    func animateTo(frame: CGRect, withDuration duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
        guard let _ = superview else {
            return
        }
        
        let xScale = frame.size.width / self.frame.size.width
        let yScale = frame.size.height / self.frame.size.height
        let x = frame.origin.x + (self.frame.width * xScale) * self.layer.anchorPoint.x
        let y = frame.origin.y + (self.frame.height * yScale) * self.layer.anchorPoint.y
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.layer.position = CGPoint(x: x, y: y)
            self.transform = self.transform.scaledBy(x: xScale, y: yScale)
        }, completion: completion)
    }
}
