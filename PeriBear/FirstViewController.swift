//
//  FirstViewController.swift
//  PeriBear
//
//  Created by Hyojeong Park on 23/10/2018.
//  Copyright © 2018 Hyojeong Park. All rights reserved.
//

import CoreBluetooth
import UIKit

class FirstViewController: UIViewController {
    var simpleBluetoothIO: SimpleBluetoothIO!
    @IBOutlet weak var lightSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "D235BA22-0D7B-064C-00C1-172B496470E5", delegate: self)
    }
    
    @IBAction func lightSwitchChanged(_ sender: Any) {
        if (lightSwitch.isOn) {
            simpleBluetoothIO.writeValue(value: 1)
        } else {
            simpleBluetoothIO.writeValue(value: 0)
        }
    }
}

extension FirstViewController: SimpleBluetoothIODelegate {
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
        if value > 0 {
            self.lightSwitch.setOn(true, animated: true);
        } else {
            self.lightSwitch.setOn(false, animated: true);
        }
    }
}
