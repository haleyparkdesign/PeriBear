//
//  ThirdViewController.swift
//  PeriBear
//
//  Created by Hyojeong Park on 31/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var toolTip: TooltipView!
    @IBOutlet weak var toolTipText: UILabel!
    @IBOutlet weak var heatSlider: UISlider!
    @IBAction func heatSliderChanged(_ sender: Any) {
        // set text value*
        let intValue = Int(heatSlider.value.rounded())
        
        if (value == 0) {
            toolTip.isHidden = true
        } else {
            toolTip.isHidden = false
            toolTipText.text = "\(intValue)" + "°C"
            // move the tooltip with the slider*
            toolTip.center.x = heatSlider.thumbCenterX
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolTip.isHidden = true
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
