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
    
    var currentTrial : Int = 1
    
    var trialIndex : Int {
        return currentTrial-1
    }
    
    var blockType : BlockType?
    var block : Block?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        print("GThan Pressed")
        blankTimer!.fire()
    }
    
    @IBAction func lessThanButtonPressed(_ sender: UIButton) {
        print("LThan Pressed")
        blankTimer!.fire()
    }
    
    @IBAction func evenButtonPressed(_ sender: UIButton) {
        print("Even Pressed")
        blankTimer!.fire()
    }
    
    @IBAction func oddButtonPressed(_ sender: UIButton) {
        print("Odd Pressed")
        blankTimer!.fire()
    }
    
    var trialTimer : Timer?
    var blankTimer : Timer?
    var repeatTimer : Timer?
    
    func executeBlock() {

        self.stimImage.image = block?.trials![trialIndex].stim!

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
    }
    
    func displayBlank() {
        self.fixationCross.isHidden = true
        self.stimImage.isHidden = true
        self.boarderView.isHidden = true
        self.setButtonVisibility(isHidden: true)
        self.currentTrial = self.currentTrial + 1
        if (trialIndex < 4) {//block!.trials!.count) {
            repeatTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: {(repeatTimer) in self.executeBlock()})
        }else{
            performSegue(withIdentifier: "returnToInstructions", sender: nil)
        }
    }
    
    func setButtonVisibility(isHidden: Bool) {
        self.greaterThanButton.isHidden = isHidden
        self.lessThanButton.isHidden = isHidden
        self.evenButton.isHidden = isHidden
        self.oddButton.isHidden = isHidden
    }
    
    /// Sets the boarder visibility
    ///
    /// - Parameter isAboveBelow: is the trial condition above/below
    func setBoarder(isAboveBelow: Bool) {
        if isAboveBelow {
            self.boarderView.isHidden = false
        } else {
            self.boarderView.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnToInstructions" {
            print("preparing for segue")
            if let viewController = segue.destination as? ViewController {
                viewController.instructionsState = .breakText
            }
        }
    }
}
