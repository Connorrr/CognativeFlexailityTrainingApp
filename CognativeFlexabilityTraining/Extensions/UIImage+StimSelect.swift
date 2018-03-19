//
//  UIImage+StimSelect.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 19/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func getEvenStimulus() -> UIImage? {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        if rand == 1 {
            image = UIImage(named: "2.png")
        }else if rand == 2 {
            image = UIImage(named: "4.png")
        }else if rand == 3 {
            image = UIImage(named: "6.png")
        }else if rand == 4 {
            image = UIImage(named: "8.png")
        }else{
            image = nil
            print("ERROR:UIIMAGE:getEvenStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return image
    }
    
    func getOddStimulus() -> UIImage? {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        if rand == 1 {
            image = UIImage(named: "1.png")
        }else if rand == 2 {
            image = UIImage(named: "3.png")
        }else if rand == 3 {
            image = UIImage(named: "7.png")
        }else if rand == 4 {
            image = UIImage(named: "9.png")
        }else{
            image = nil
            print("ERROR:UIIMAGE:getOddStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return image
    }
    
    func getAboveStimulus() -> UIImage? {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        if rand == 1 {
            image = UIImage(named: "6.png")
        }else if rand == 2 {
            image = UIImage(named: "7.png")
        }else if rand == 3 {
            image = UIImage(named: "8.png")
        }else if rand == 4 {
            image = UIImage(named: "9.png")
        }else{
            image = nil
            print("ERROR:UIIMAGE:getAboveStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return image
    }
    
    func getBelowStimulus() -> UIImage? {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        if rand == 1 {
            image = UIImage(named: "1.png")
        }else if rand == 2 {
            image = UIImage(named: "2.png")
        }else if rand == 3 {
            image = UIImage(named: "3.png")
        }else if rand == 4 {
            image = UIImage(named: "4.png")
        }else{
            image = nil
            print("ERROR:UIIMAGE:getAboveStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return image
    }
    
}
