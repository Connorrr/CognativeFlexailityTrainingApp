//
//  TrialViewController.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit
import Foundation

class BlockViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var stimImage: UIImageView!
    @IBOutlet weak var fixationCross: UILabel!
    @IBOutlet weak var boarderView: UIView!
    
    @IBOutlet weak var greaterThanButton: ResponseButton!
    @IBOutlet weak var lessThanButton: ResponseButton!
    @IBOutlet weak var evenButton: ResponseButton!
    @IBOutlet weak var oddButton: ResponseButton!
    
    var blockType : BlockType?
    var block : Block?
    var blockProgress : Int?
    var blockData = BlockData()
    
    var trialIndex : Int {
        return currentTrial-1
    }
    var currentTrial : Int = 1
    var trialData : TrialData?
    var trialTime : Double?
    var trialStartTime : Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("The block type is:  ")
        dump(blockType)
        
        let random = false
        if blockType != nil {
            if blockType == .mixed {
                if random.randomBool() {
                    block = Block(startingTrialCondition: .even, numerOfSwitches: 4)
                } else {
                    block = Block(startingTrialCondition: .above, numerOfSwitches: 4)
                }
            }else{
                if random.randomBool() {
                    block = Block(trialCondition: .even)
                } else {
                    block = Block(trialCondition: .above)
                }
            }
            
            executeBlock()
            
        }else{
            questionLabel.text = "ERROR"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func greaterThanButtonPressed(_ sender: UIButton) {
        blankTimer!.fire()
        trialData?.response = "Greater"
    }
    
    @IBAction func lessThanButtonPressed(_ sender: UIButton) {
        blankTimer!.fire()
        trialData?.response = "Less"
    }
    
    @IBAction func evenButtonPressed(_ sender: UIButton) {
        blankTimer!.fire()
        trialData?.response = "Even"
    }
    
    @IBAction func oddButtonPressed(_ sender: UIButton) {
        blankTimer!.fire()
        trialData?.response = "Odd"
    }
    
    var trialTimer : Timer?
    var blankTimer : Timer?
    var repeatTimer : Timer?
    
    func executeBlock() {

        self.stimImage.image = block?.trials![trialIndex].stim!
        
        setUpTrialData()
        
        //  Display Fixation for 1400 ms
        displayFixation()
    
        //  Show trial for 5000ms or first response
        trialTimer = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false, block: { (trialTimer) in self.displayTrial() })
    
        //  25ms blank (called in displayTrial)
        
    }
    
    func displayFixation() {
        self.fixationCross.isHidden = false
        self.stimImage.isHidden = true
        self.boarderView.isHidden = true
        self.setButtonVisibility(isHidden: true)
    }
    
    func displayTrial() {
        self.setBoarder(isAboveBelow: block!.trials![trialIndex].isAboveBelow!)
        self.fixationCross.isHidden = true
        self.stimImage.isHidden = false
        self.setButtonVisibility(isHidden: false)
        self.blankTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { (blankTimer) in self.displayBlank() })
        trialStartTime = Date()
    }
    
    func displayBlank() {
        getResponseTime()
        self.fixationCross.isHidden = true
        self.stimImage.isHidden = true
        self.boarderView.isHidden = true
        self.setButtonVisibility(isHidden: true)
        self.currentTrial = self.currentTrial + 1
        let defaults = UserDefaults.standard
        let startTime = defaults.object(forKey: "startTime") as! Date
        trialData?.time = Date(timeIntervalSinceNow: 0.25).timeIntervalSince(startTime).description
        blockData.trialDataArray[trialIndex] = trialData!
        if (trialIndex < 4) {//block!.trials!.count) {  TODO:  remove this before finish
            repeatTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {(repeatTimer) in self.executeBlock()})
        }else{
            LogFileData.logData[trialIndex] = blockData
            performSegue(withIdentifier: "returnToInstructions", sender: nil)
        }
    }
    
    func setButtonVisibility(isHidden: Bool) {
        self.greaterThanButton.isHidden = isHidden
        self.lessThanButton.isHidden = isHidden
        self.evenButton.isHidden = isHidden
        self.oddButton.isHidden = isHidden
    }
    
    func getResponseTime() {
        let endTime = Date()
        let rT = endTime.timeIntervalSince(trialStartTime!)
        print("Execution time: \(rT)")
        trialData?.rt = rT
    }
    
    func checkCorr(response: TrialCondition) {
        if response == block!.trials![trialIndex].correctResponse {
            trialData?.corr = 1
        }else{
            trialData?.corr = 0
        }
    }
    
    /// Sets the boarder visibility for the ox around stim
    func setBoarder(isAboveBelow: Bool) {
        if isAboveBelow {
            self.boarderView.isHidden = false
        } else {
            self.boarderView.isHidden = true
        }
    }
    
    func setUpTrialData() {
        trialData = TrialData()
        trialData?.trialNum = currentTrial
        trialData?.blockNumber = blockProgress
        
        switch blockType! {
        case .practice:
            trialData?.blockType = "Practice"
        case .mixed:
            trialData?.blockType = "Mixed"
        case .single:
            trialData?.blockType = "Single"
        }
        
        trialData?.stim = block?.trials![trialIndex].stimName!
        
        switch block!.trials![trialIndex].condition! {
        case .even:
            trialData?.trialCondition = "even"
        case .odd:
            trialData?.trialCondition = "odd"
        case .above:
            trialData?.trialCondition = "above"
        case .below:
            trialData?.trialCondition = "below"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnToInstructions" {
            print("preparing for segue")
            if let viewController = segue.destination as? ViewController {
                if blockProgress! + 1 < viewController.experimentStructure.count {
                    viewController.instructionsState = .breakText
                }else{
                    viewController.instructionsState = .goodbyeText
                }
                
                viewController.blockProgress = blockProgress! + 1
            }
        }
    }
}
