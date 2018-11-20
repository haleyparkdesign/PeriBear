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
    @IBOutlet weak var TemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "0000ffe0-0000-1000-8000-00805f9b34fb", delegate: self)
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
        
        print(value)
        
        TemperatureLabel.text = String(value) + "°C"
    }
}
