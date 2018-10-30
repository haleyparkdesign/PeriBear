//
//  CustomSegmentedControl.swift
//  PeriBear
//
//  Created by Hyojeong Park on 30/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    let customBlack = UIColor(displayP3Red: 42/255.0, green: 46/255.0, blue: 67/255.0, alpha: 1.0)
    let tintRed = UIColor(displayP3Red: 242/255.0, green: 91/255.0, blue: 91/255.0, alpha: 1.0)
    
    var sortedViews: [UIView]!
    var currentIndex: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        sortedViews = self.subviews.sorted(by:{$0.frame.origin.x < $1.frame.origin.x})
        changeSelectedIndex(to: currentIndex)
        
        // set width and height of segmented control
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        self.setWidth(screenWidth/2, forSegmentAt: 0)
        self.setWidth(screenWidth/2, forSegmentAt: 1)
        
        // set font
        let unselectedAttributes = [NSAttributedString.Key.foregroundColor: customBlack,
                                    NSAttributedString.Key.font:  UIFont(name: "ApercuPro", size: UIFont.labelFontSize)]
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: tintRed,
                                  NSAttributedString.Key.font:  UIFont(name: "ApercuPro", size: UIFont.labelFontSize)]
        self.setTitleTextAttributes(unselectedAttributes as [NSAttributedString.Key : Any], for: .normal)
        self.setTitleTextAttributes(selectedAttributes as [NSAttributedString.Key : Any], for: .selected)
        
        // remove the border
        self.removeBorders()
        
        self.addUnderlineForSelectedSegment()
    }
    
    func changeSelectedIndex(to newIndex: Int) {
        sortedViews[currentIndex].backgroundColor = UIColor.clear
        currentIndex = newIndex
        self.selectedSegmentIndex = UISegmentedControl.noSegment
        sortedViews[currentIndex].backgroundColor =  UIColor.clear
        self.addUnderlineForSelectedSegment()
    }
    
    // function to remove the border
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: UIColor.clear), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: UIColor.clear), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    // helper function for removeBorders(). creates a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
    
    func addUnderlineForSelectedSegment() {
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = tintRed
        underline.tag = 13
        self.addSubview(underline)
        
        print(self.bounds.size.height)
        print(underLineYPosition)
        
    }
    
    func changeUnderlinePosition() {
        guard let underline = self.viewWithTag(13) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}
