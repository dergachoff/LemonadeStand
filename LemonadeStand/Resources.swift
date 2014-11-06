//
//  Resources.swift
//  LemonadeStand
//
//  Created by Ivan Dergachev on 05/11/14.
//  Copyright (c) 2014 Ivan Dergachev. All rights reserved.
//

import Foundation

class Resources {
    
    var money = 0
    var lemons = 0
    var iceCubes = 0
    
    func emptyBasket() {
        money = 0
        lemons = 0
        iceCubes = 0
    }
    
    func initialInvestment() {
        money = 10
        lemons = 1
        iceCubes = 1
    }
}
