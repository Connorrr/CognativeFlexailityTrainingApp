//
//  Integer+Random.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 19/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation

extension Int {
    
    func getRandomInt(low: Int, high: Int) -> Int? {
        return arc4random_uniform((high - low + 1) + low)
    }
    
}
