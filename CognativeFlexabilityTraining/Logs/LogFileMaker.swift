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
    
    
    /// Saves the data from LogFileData into csv on the local directory with the filename specified
    func saveData() {
        dump(LogFileData.logData)
        let logString = convertLogFileDataToCSVString()
        print(logString)
        
        let file = "\(fName).csv" //this is the file. we will write to and read from it
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            
            //writing
            do {
                try logString.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                print("LogFileMaker: SaveData():  Could not save the log file.")
            }

        }
    }
    
    private func convertLogFileDataToCSVString() -> String {
        var csvString = "Block No, Trial No, Trial Type, Trial Condition, Stim, Response, Rt, Correct, Time Elapsed\n"
        
        for blockData in LogFileData.logData {
            for trialData in blockData.trialDataArray {
                csvString.append("\(String(describing: trialData.blockNumber)),\(String(describing: trialData.trialNum)),\(String(describing: trialData.trialCondition)),\(String(describing: trialData.stim)),\(String(describing: trialData.response)),\(String(describing: trialData.rt)),\(String(describing: trialData.corr)),\(String(describing: trialData.time))\n")
            }
        }
        
        return csvString
    }
}
