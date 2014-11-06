//
//  Weather.swift
//  LemonadeStand
//
//  Created by Ivan Dergachev on 06/11/14.
//  Copyright (c) 2014 Ivan Dergachev. All rights reserved.
//

import Foundation
import UIKit

class Weather {
    var weather = 0
    var weatherIcon = UIImage(named: "")
    
    func checkWeather() {
        self.weather = Business.calcRandomInt(3)
        
        switch weather {
        case 0:
            weatherIcon = UIImage(named: "cold")
        case 1:
            weatherIcon = UIImage(named: "mild")
        case 2:
            weatherIcon = UIImage(named: "warm")
        default:
            weatherIcon = UIImage(named: "mild")
        }
        
    }
}