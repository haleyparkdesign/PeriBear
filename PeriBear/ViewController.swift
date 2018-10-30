//
//  ViewController.swift
//  PeriBear
//
//  Created by Hyojeong Park on 23/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var temperatureToolTip: TooltipView!
    @IBOutlet weak var temperatureToolTipText: UILabel!
    @IBOutlet weak var heatSlider: UISlider!
    @IBAction func heatSliderChanged(_ sender: Any) {
        // set text value
        var value = heatSlider.value
        value *= 100
        let intValue = Int(value.rounded())
        temperatureToolTipText.text = "\(intValue)" + "°C"
        
        // move the tooltip with the slider
        temperatureToolTip.center.x = heatSlider.thumbCenterX
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// get UISlider thumb position
extension UISlider {
    var thumbCenterX: CGFloat {
        let trackRect = self.trackRect(forBounds: frame)
        let thumbRect = self.thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
        return thumbRect.midX
    }
}
