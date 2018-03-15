//
//  Block.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation

class Block {
    
    let blockType : BlockType
    let numberOfTrials : Int = 17
    let startTrialCondition : TrialCondition
    let numSwitches : Int?
    var trials : [TrialInfo]?
    
    
    
    /// Single condition initializer
    ///
    /// - Parameter trialCondition: This is the trial condition that will define wheather it is even/odd or above/below (note: the specific condition will be ignored)
    init(trialCondition: TrialCondition) {
        blockType = .single
        startTrialCondition = trialCondition
        numSwitches = nil
        buildTrialList()
    }
    
    /// Mixed condition initialized
    ///
    /// - Parameters:
    ///   - startingTrialCondition: This is the trial condition that will define wheather we start with even/odd or above/below (note: the specific condition will be ignored)
    ///   - numerOfSwitches: number of switches in throughout the trial list
    init(startingTrialCondition: TrialCondition, numerOfSwitches: Int) {
        blockType = .mixed
        startTrialCondition = startingTrialCondition
        numSwitches = numerOfSwitches
        buildTrialList()
    }
    
    private func buildTrialList() {
        
        var trial = TrialInfo()
        var isevenOdd = true
        if (startTrialCondition == .above || startTrialCondition == .below) {
            isevenOdd = false
        }

        for i in 1 ... numberOfTrials {
                
            if blockType == .mixed {
                let switchEvery = numberOfTrials/numSwitches!
                    
                if ( i % switchEvery == 0 ) {
                    isevenOdd = !isevenOdd
                }
                    
            }
                
            if isevenOdd {
                trial.question = "Is this number Even or Odd?"
                if randomBool() {
                    trial.condition = .even
                }else{
                    trial.condition = .odd
                }
            }else{
                trial.question = "Is this number Aove or Below 5?"
                if randomBool() {
                    trial.condition = .above
                }else{
                    trial.condition = .below
                }
            }
                
                
            trials?.append(trial)
        }

    }
    
    private func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
}