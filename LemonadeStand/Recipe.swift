//
//  Recipe.swift
//  LemonadeStand
//
//  Created by Ivan Dergachev on 06/11/14.
//  Copyright (c) 2014 Ivan Dergachev. All rights reserved.
//

import Foundation

class Recipe {
    var lemons = 0
    var iceCubes = 0
    
    var isAcidic = false
    var isNormal = false
    var isDiluted = false
    
    func mix() {
        var recipeMix: Double
        recipeMix = Double(lemons) / Double(iceCubes)

        if recipeMix > 1.0 {
            self.isAcidic = true;
        } else if recipeMix < 1.0 {
            isDiluted = true
        } else if recipeMix == 1.0 {
            isNormal = true
        }
            
        
    }
}