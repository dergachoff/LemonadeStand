//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Ivan Dergachev on 04/11/14.
//  Copyright (c) 2014 Ivan Dergachev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    
    // Setting up Resources labels
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var lemonsLabel: UILabel!
    @IBOutlet weak var iceCubesLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    // Setting up Store labels
    
    @IBOutlet weak var storeLemonsSelected: UILabel!
    @IBOutlet weak var storeIceCubesSelected: UILabel!
    
    @IBOutlet weak var storeLemonMinusButton: UIButton!
    @IBOutlet weak var storeLemonPlusButton: UIButton!
    
    @IBOutlet weak var storeIceMinusButton: UIButton!
    @IBOutlet weak var storeIcePlusButton: UIButton!
    
    @IBOutlet weak var storeBuyButton: UIButton!
    
    // setting up Recipe labels
    
    @IBOutlet weak var recipeLemonsSelected: UILabel!
    @IBOutlet weak var recipeIceCubesSelected: UILabel!

    @IBOutlet weak var recipeLemonMinusButton: UIButton!
    @IBOutlet weak var recipeLemonPlusButton: UIButton!
    
    @IBOutlet weak var recipeIceMinusButton: UIButton!
    @IBOutlet weak var recipeIcePlusButton: UIButton!
    
    // setting up Start Day Button
    
    @IBOutlet weak var startDayButton: UIButton!
    
    // setting up resources, basket and weather
    
    var pocket = Resources()
    var basket = Resources()
    var currentWeather = Weather()
    
    // setting up prices
    
    var lemonPrice = 2
    var icePrice = 1
    
    // setting up recipe mix 
    
    var currentRecipe = Recipe()
    
    // setting up today
    
    var currentDay = 0
    
    // setting up customers
    
    var customerCrowd:[Customer] = []
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // setting up stuff after loading for the first time
        
        pocket.initialInvestment()
        currentWeather.checkWeather()
        updateAllLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // setting up button actions
    
    @IBAction func storeLemonMinusButtonPressed(sender: AnyObject) {
        basket.lemons -= 1
        basket.money -= lemonPrice
        updateAllLabels()
    }
   
    @IBAction func storeLemonPlusButtonPressed(sender: AnyObject) {
        basket.lemons += 1
        basket.money += lemonPrice
        updateAllLabels()
    }
    
    @IBAction func storeIceMinusButtonPressed(sender: AnyObject) {
        basket.iceCubes -= 1
        basket.money -= icePrice
        updateAllLabels()
    }
    
    @IBAction func storeIcePlusButtonPressed(sender: AnyObject) {
        basket.iceCubes += 1
        basket.money += icePrice
        updateAllLabels()
    }
    
    @IBAction func buyNowButtonPressed(sender: AnyObject) {
        Business.makePurchase(basket, pocket: pocket)
        updateAllLabels()
    }
    
    @IBAction func recipeLemonMinusButtonPressed(sender: AnyObject) {
        currentRecipe.lemons -= 1
        pocket.lemons += 1
        updateAllLabels()
    }
    
    @IBAction func recipeLemonPlusButtonPressed(sender: AnyObject) {
        currentRecipe.lemons += 1
        pocket.lemons -= 1
        updateAllLabels()
    }
    
    @IBAction func recipeIceMinusButtonPressed(sender: AnyObject) {
        currentRecipe.iceCubes -= 1
        pocket.iceCubes += 1
        updateAllLabels()
    }
    
    @IBAction func recipeIcePlusButtonPressed(sender: AnyObject) {
        currentRecipe.iceCubes += 1
        pocket.iceCubes -= 1
        updateAllLabels()
    }
    
    
    @IBAction func startDayButtonPressed(sender: AnyObject) {
        getThroughTheDay()
    }
    
    
    // quick way to update Pocket UI
    
    func updatePocketLabels() {
        moneyLabel.text = "$\(pocket.money)"
        lemonsLabel.text = "\(pocket.lemons)"
        iceCubesLabel.text = "\(pocket.iceCubes)"
    }
    
    // quick way to update Store UI
    
    func updateStoreLabels() {
        storeLemonsSelected.text = "\(basket.lemons)"
        storeIceCubesSelected.text = "\(basket.iceCubes)"
        
        
        // showing-hiding UI elements for better UX
        
        if basket.lemons <= 0 {
            storeLemonMinusButton.hidden = true
        } else {
            storeLemonMinusButton.hidden = false
        }
        
        if pocket.money < (basket.money + lemonPrice) {
            storeLemonPlusButton.hidden = true
        } else {
            storeLemonPlusButton.hidden = false
        }
        
        
        if basket.iceCubes <= 0 {
            storeIceMinusButton.hidden = true
        } else {
            storeIceMinusButton.hidden = false
        }
        
        if pocket.money < (basket.money + icePrice) {
            storeIcePlusButton.hidden = true
        } else {
            storeIcePlusButton.hidden = false
        }
        
        if basket.money > 0 {
            storeBuyButton.hidden = false
        } else {
            storeBuyButton.hidden = true
        }
        
        
    }
    
    // quick way to update Recipe UI
    
    func updateRecipeLabels() {
        recipeLemonsSelected.text = "\(currentRecipe.lemons)"
        recipeIceCubesSelected.text = "\(currentRecipe.iceCubes)"
        
        if currentRecipe.lemons <= 0 {
            recipeLemonMinusButton.hidden = true
        } else {
            recipeLemonMinusButton.hidden = false
        }
        
        if pocket.lemons <= 0 {
            recipeLemonPlusButton.hidden = true
        } else {
            recipeLemonPlusButton.hidden = false
        }
        
        if currentRecipe.lemons <= 0 {
            recipeIceMinusButton.hidden = true
        } else {
            recipeIceMinusButton.hidden = false
        }
        
        if pocket.iceCubes <= 0 {
            recipeIcePlusButton.hidden = true
        } else {
            recipeIcePlusButton.hidden = false
        }
        
        if currentRecipe.iceCubes > 0 && currentRecipe.lemons > 0 {
            startDayButton.hidden = false
        } else {
            startDayButton.hidden = true
        }
    
    }
    
    // a handy shortcut to update all UI in one call
    
    func updateAllLabels() {
        updatePocketLabels()
        updateStoreLabels()
        updateRecipeLabels()
        self.weatherImage.image = currentWeather.weatherIcon
        checkForGameOver()
    }
    

    // this is what will happen when you press start day
    
    func getThroughTheDay() {
        
        var dailyEarnings = 0
        
        println("It's a good day to start a little lemonade business!")
        
        // mix the lemonade
        
        currentRecipe.mix()
        if currentRecipe.isAcidic {
            println("Today we're serving bitter lemonade.")
        } else if currentRecipe.isDiluted {
            println("Today we're serving diluted lemonade.")
        } else {
            println("Today we're serving perfectly balanced lemonade")
        }
        
        // attract the crowd
        
        var amountOfCustomers = Business.calcRandomInt(5) + 6
        
        switch currentWeather.weather {
            case 0: amountOfCustomers -= (Business.calcRandomInt(3) + 1)
            case 2: amountOfCustomers += (Business.calcRandomInt(4) + 1)
            default: amountOfCustomers += 0
        }
        
        for var i = 0; i < amountOfCustomers; i++ {
            let babyCustomer = Customer()
            babyCustomer.giveBirth()
            customerCrowd.append(babyCustomer)
        }
        
        println("During the day you've been visited \(customerCrowd.count) times.")
        
        // deal with each customer
        
        for var i = 0; i < customerCrowd.count; i++ {
            
            if currentRecipe.isAcidic && customerCrowd[i].likesAcidicLemonade {
                println("\(customerCrowd[i].name) likes acidic lemonade and paid $1")
                dailyEarnings += 1
            } else if currentRecipe.isNormal && customerCrowd[i].likesNormalLemonade {
                println("\(customerCrowd[i].name) likes normal lemonade and paid $1")
                dailyEarnings += 1
            } else if currentRecipe.isDiluted && customerCrowd[i].likesDilutedLemonade {
                println("\(customerCrowd[i].name) likes diluted lemonade and paid $1")
                dailyEarnings += 1
            } else {
                println("\(customerCrowd[i].name) likes something that you don't offer and passed by.")
            }
        }
        
        
        // check wallet
        
        if dailyEarnings > 0 {
            var amountOfTips = Business.calcRandomInt(dailyEarnings)
            println("Congratulations, you've made $\(dailyEarnings) this day! And also $\(amountOfTips) in tips!")
            pocket.money += dailyEarnings
            pocket.money += amountOfTips
            
            
        } else {
            println("You've made nothing. You'll have better days in your carreer. I guess.")
        }
        
        // remove used stuff, let's prepare for the next day!
        
        customerCrowd.removeAll(keepCapacity: true)
        currentRecipe = Recipe()
        basket.emptyBasket()
        
        
        currentDay += 1
        currentWeather.checkWeather()
        
        dayLabel.text = "Lemonade Stand – Day \(currentDay)"
        startDayButton.setTitle("Start Day \(currentDay + 1)", forState: UIControlState.Normal)
        
        updateAllLabels()
    }
    
    func checkForGameOver() {
        if (currentRecipe.lemons == 0 && pocket.lemons == 0 && pocket.money < lemonPrice) || (currentRecipe.iceCubes == 0 && pocket.iceCubes == 0 && pocket.money < icePrice) {
            
            var alert = UIAlertController(title: "Game Over!", message: "Sorry, young dude, your business is closed on day \(currentDay). Yeah, blame it on economy...", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Wah Wah Wah", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

            startFromScratch()
            updateAllLabels()
        }
    }
    
    func startFromScratch() {
        pocket.initialInvestment()
        basket.emptyBasket()
        currentDay = 1
        currentWeather.checkWeather()
        dayLabel.text = "Lemonade Stand – Day \(currentDay)"
        startDayButton.setTitle("Start Day \(currentDay + 1)", forState: UIControlState.Normal)
    }

}

