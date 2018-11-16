//
//  ThirdViewController.swift
//  PeriBear
//
//  Created by Hyojeong Park on 31/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    // switches
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    
    // for tooltip
    @IBOutlet weak var toolTip: TooltipView!
    @IBOutlet weak var toolTipText: UILabel!
    @IBOutlet weak var heatSlider: UISlider!
    @IBAction func heatSliderChanged(_ sender: Any) {
        // set text value*
        let intValue = Int(heatSlider.value.rounded())
        
        toolTipText.text = "\(intValue)" + "°C"
        // move the tooltip with the slider*
        toolTip.center.x = heatSlider.thumbCenterX
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Only one switch can be on
    @IBAction func switch1Changed(_ sender: Any) {
        if (switch1.isOn) {
            if (switch2.isEnabled) {
                switch2.setOn(false, animated: true)
            }
            if (switch3.isEnabled) {
                switch3.setOn(false, animated: true)
            }
            if (switch4.isEnabled) {
                switch4.setOn(false, animated: true)
            }
        }
    }
    
    @IBAction func switch2Changed(_ sender: Any) {
        if (switch2.isOn) {
            if (switch1.isEnabled) {
                switch1.setOn(false, animated: true)
            }
            if (switch3.isEnabled) {
                switch3.setOn(false, animated: true)
            }
            if (switch4.isEnabled) {
                switch4.setOn(false, animated: true)
            }
        }
    }
    
    @IBAction func switch3Changed(_ sender: Any) {
        if (switch3.isOn) {
            if (switch1.isEnabled) {
                switch1.setOn(false, animated: true)
            }
            if (switch2.isEnabled) {
                switch2.setOn(false, animated: true)
            }
            if (switch4.isEnabled) {
                switch4.setOn(false, animated: true)
            }
        }
    }
    
    @IBAction func switch4Changed(_ sender: Any) {
        if (switch4.isOn) {
            if (switch1.isEnabled) {
                switch1.setOn(false, animated: true)
            }
            if (switch2.isEnabled) {
                switch2.setOn(false, animated: true)
            }
            if (switch3.isEnabled) {
                switch3.setOn(false, animated: true)
            }
        }
    }
    
}

// get UISlider thumb position*
extension UISlider {
    var thumbCenterX: CGFloat {
        let trackRect = self.trackRect(forBounds: frame)
        let thumbRect = self.thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
        return thumbRect.midX
    }
}
