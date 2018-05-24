//
//  Block.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation
import UIKit

class Block {
    
    let blockType : BlockType
    let numberOfTrials : Int = 17
    let startTrialCondition : TrialCondition
    let numSwitches : Int?
    var trials : [TrialInfo]? = []
    
    
    
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
        
        let img = UIImage()
        
        var trial = TrialInfo()
        var isevenOdd = true
        if (startTrialCondition == .vege || startTrialCondition == .fruit) {
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
                trial.isAboveBelow = false
                if isevenOdd.randomBool() {
                    let data = img.getRedStimulus()
                    trial.condition = .red
                    trial.stim = data.0
                    trial.stimName = data.1?.description
                }else{
                    let data = img.getGreenStimulus()
                    trial.condition = .green
                    trial.stim = data.0
                    trial.stimName = data.1?.description
                }
            }else{
                trial.question = "Is this number Above or Below 5?"
                trial.isAboveBelow = true
                if isevenOdd.randomBool() {
                    let data = img.getVegeStimulus()
                    trial.condition = .vege
                    trial.stim = data.0
                    trial.stimName = data.1?.description
                }else{
                    let data = img.getFruitStimulus()
                    trial.condition = .fruit
                    trial.stim = data.0
                    trial.stimName = data.1?.description
                }
            }
                
            trials?.append(trial)
        }

    }
    
}
