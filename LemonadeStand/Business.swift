//
//  Shop.swift
//  LemonadeStand
//
//  Created by Ivan Dergachev on 05/11/14.
//  Copyright (c) 2014 Ivan Dergachev. All rights reserved.
//

import Foundation

class Business {
    
    class func makePurchase(basket: Resources, pocket: Resources) {
        pocket.money -= basket.money
        pocket.lemons += basket.lemons
        pocket.iceCubes += basket.iceCubes
        basket.emptyBasket()
    }
    
    class func calcRandomInt(inputInt: Int) -> Int {
        return Int(arc4random_uniform(UInt32(inputInt)))
    }
}