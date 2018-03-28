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
    
    func getEvenStimulus() -> (UIImage?, UInt32?) {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        if rand == 1 {
            image = #imageLiteral(resourceName: "2.png")
        }else if rand == 2 {
            image = #imageLiteral(resourceName: "4.png")
        }else if rand == 3 {
            image = #imageLiteral(resourceName: "6.png")
        }else if rand == 4 {
            image = #imageLiteral(resourceName: "8.png")
        }else{
            image = nil
            print("ERROR:UIIMAGE:getEvenStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return (image, rand)
    }
    
    func getOddStimulus() -> (UIImage?, UInt32?)  {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        if rand == 1 {
            image = #imageLiteral(resourceName: "1.png")
        }else if rand == 2 {
            image = #imageLiteral(resourceName: "3.png")
        }else if rand == 3 {
            image = #imageLiteral(resourceName: "7.png")
        }else if rand == 4 {
            image = #imageLiteral(resourceName: "9.png")
        }else{
            image = nil
            print("ERROR:UIIMAGE:getOddStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return (image, rand)
    }
    
    func getAboveStimulus() -> (UIImage?, UInt32?) {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        if rand == 1 {
            image = #imageLiteral(resourceName: "6.png")
        }else if rand == 2 {
            image = #imageLiteral(resourceName: "7.png")
        }else if rand == 3 {
            image = #imageLiteral(resourceName: "8.png")
        }else if rand == 4 {
            image = #imageLiteral(resourceName: "9.png")
        }else{
            image = nil
            print("ERROR:UIIMAGE:getAboveStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return (image, rand)
    }
    
    func getBelowStimulus() -> (UIImage?, UInt32?) {
        let int : UInt32 = 0
        var image : UIImage?
        
        let rand = int.getRandomInt(low: 1, high: 4)
        if rand == 1 {
            image = #imageLiteral(resourceName: "1.png")
        }else if rand == 2 {
            image = #imageLiteral(resourceName: "2.png")
        }else if rand == 3 {
            image = #imageLiteral(resourceName: "3.png")
        }else if rand == 4 {
            image = #imageLiteral(resourceName: "4.png")
        }else{
            image = nil
            print("ERROR:UIIMAGE:getAboveStimulus: incorrect random value:  \(String(describing: rand))")
        }
        
        return (image,rand)
    }
    
}
