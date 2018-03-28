//
//  LogFileMaker.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 27/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import Foundation

class LogFileMaker {
    var fName: String
    
    init(fileName: String) {
        fName = fileName
    }
    
    func convertLogFileDataToCSVString() -> String {
        var csvString = "Block No, Trial No, Trial Type, Trial Condition, Stim, Response, Rt, Correct, Time Elapsed\n"
        
        for blockData in LogFileData.logData {
            for trialData in blockData.trialDataArray {
                csvString.append("\(String(describing: trialData.blockNumber)),\(String(describing: trialData.trialNum)),\(String(describing: trialData.trialType)),\(String(describing: trialData.trialCondition)),\(String(describing: trialData.stim)),\(String(describing: trialData.response)),\(String(describing: trialData.rt)),\(String(describing: trialData.corr)),\(String(describing: trialData.time))\n")
            }
        }
        
        return csvString
    }
}
