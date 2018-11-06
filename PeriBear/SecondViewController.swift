//
//  SecondViewController.swift
//  PeriBear
//
//  Created by Hyojeong Park on 23/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import UIKit
import FSCalendar

var cycle = 28
var duaration = 5

class SecondViewController: UIViewController {
    @IBOutlet weak var cycleDays: UILabel!
    @IBOutlet weak var CycleHistoryBtn: UIButton!
    @IBOutlet weak var CalendarBtn: UIButton!
    @IBOutlet weak var TintedUnderline: UIView!
    @IBOutlet weak var HistoryView: UIView!
    @IBOutlet weak var CalendarView: FSCalendar!
    @IBOutlet weak var TodayButton: UIButton!
    @IBOutlet weak var OvulationButton: UIButton!
    
    // toggles between two views
    @IBAction func CalendarBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.TintedUnderline.frame.origin.x = UIScreen.main.bounds.width / 2
        }, completion: { finished in
        })
        
        CalendarBtn.titleLabel?.font =  UIFont(name: "ApercuPro-Medium", size: 18)
        CycleHistoryBtn.titleLabel?.font =  UIFont(name: "ApercuPro", size: 18)
        
        HistoryView.isHidden = true
        CalendarView.isHidden = false
    }
    @IBAction func CycleHistoryBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.TintedUnderline.frame.origin.x = 0
        }, completion: { finished in
        })
        
        CycleHistoryBtn.titleLabel?.font =  UIFont(name: "ApercuPro-Bold", size: 18)
        CalendarBtn.titleLabel?.font =  UIFont(name: "ApercuPro", size: 18)
        HistoryView.isHidden = false
        CalendarView.isHidden = true
    }
    @IBAction func TodayTapped(_ sender: Any) {
        CalendarView.setCurrentPage(Date(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        CalendarView.isHidden = true
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
