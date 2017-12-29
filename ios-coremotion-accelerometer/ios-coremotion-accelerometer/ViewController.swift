//
//  ViewController.swift
//  ios-coremotion-accelerometer
//
//  Created by OkuderaYuki on 2017/12/30.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import CoreMotion
import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var xLabel: UILabel!
    @IBOutlet private weak var yLabel: UILabel!
    @IBOutlet private weak var zLabel: UILabel!

    let motionManager = CMMotionManager()
    let lowPassFilter = 0.1

    var accelX: UIAccelerationValue = 0.0
    var accelY: UIAccelerationValue = 0.0
    var accelZ: UIAccelerationValue = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        startAccelerometer()
    }

    /// 加速度の計測を開始する
    private func startAccelerometer() {

        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in

            if let error = error {
                print("Error Code: \((error as NSError).code)")
                print("Error Domain: \((error as NSError).domain)")
                return
            }

            guard let accelerometerData = accelerometerData else {
                return
            }

            // Low Path Filtering
            self.accelX = (self.accelX * (1.0 - self.lowPassFilter)) +
                (accelerometerData.acceleration.x * self.lowPassFilter)
            self.accelY = (self.accelY * (1.0 - self.lowPassFilter)) +
                (accelerometerData.acceleration.y * self.lowPassFilter)
            self.accelX = (self.accelZ * (1.0 - self.lowPassFilter)) +
                (accelerometerData.acceleration.z * self.lowPassFilter)

            self.xLabel.text = String(format: "x = %.3f", self.accelX)
            self.yLabel.text = String(format: "y = %.3f", self.accelY)
            self.zLabel.text = String(format: "z = %.3f", self.accelZ)
        }
    }

}
