//
//  CustomTextField.swift
//  PeriBear
//
//  Created by Hyojeong Park on 29/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField : UITextField {
    let gray0 = UIColor(displayP3Red: 250/255.0, green: 250/255.0, blue: 253/255.0, alpha: 1.0)
    let gray1 = UIColor(displayP3Red: 115/255.0, green: 117/255.0, blue: 132/255.0, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
        
        self.layer.borderWidth = 0
        self.backgroundColor = gray0
        //        self.tintColor = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        
        self.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        self.layer.shadowColor = gray1.cgColor
        self.layer.shadowOpacity = 0.25
        
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
}
