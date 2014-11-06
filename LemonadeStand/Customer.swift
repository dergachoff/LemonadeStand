//
//  Customer.swift
//  LemonadeStand
//
//  Created by Ivan Dergachev on 05/11/14.
//  Copyright (c) 2014 Ivan Dergachev. All rights reserved.
//

import Foundation

class Customer {
    
    var name = "Nameless One"
    var likesNormalLemonade = false
    var likesDilutedLemonade = false
    var likesAcidicLemonade = false
    
    func giveBirth() {
        
        var fullNamesArray = [
        "Booker Billman",
        "Brady Marmon",
        "Faustino Niver",
        "Leandro Angulo",
        "Deon Baughn",
        "Rafael Funchess",
        "Lyle Mendosa",
        "Bertram Shows",
        "Tracy Chafin",
        "Jimmie Cavaliere",
        "Carmen Macrae",
        "Hank Hiner",
        "Billie Emerick",
        "Oliver Kovacich",
        "Osvaldo Beecroft",
        "Erwin Demartino",
        "Wilfredo Corriveau",
        "Roosevelt Gratz",
        "Bryan Chiaramonte",
        "Federico Taormina"
        ]
        
        var randomNameNumber = Business.calcRandomInt(fullNamesArray.count)
        
        self.name = "\(fullNamesArray[randomNameNumber])"
        
        var taste: Double = 0.5
        
        taste = (Double(Business.calcRandomInt(10)) + 1.0) * 0.1
        
        if taste < 0.4 {
            self.likesAcidicLemonade = true
        } else if taste > 0.6 {
            self.likesDilutedLemonade = true
        } else {
            self.likesNormalLemonade = true
        }
        
    }
    
}