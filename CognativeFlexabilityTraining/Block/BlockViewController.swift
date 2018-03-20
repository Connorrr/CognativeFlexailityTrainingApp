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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
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
            
            stimImage.image = block!.trials![0].stim!
            setBoarder(isAboveBelow: (block!.trials![trialIndex].isAboveBelow)!)
            
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
        trialTimer?.fire()
    }
    
    @IBAction func lessThanButtonPressed(_ sender: UIButton) {
        trialTimer?.fire()
    }
    
    @IBAction func evenButtonPressed(_ sender: UIButton) {
        trialTimer?.fire()
    }
    
    @IBAction func oddButtonPressed(_ sender: UIButton) {
        trialTimer?.fire()
    }
    
    var trialTimer : Timer?
    
    func executeBlock() {
        for _ in 0..<block!.trials!.count {

            //  Display Fixation for 1400 ms
            displayFixation()
        
            //  Show trial for 5000ms or first response
            displayTrial()
        
            //  25ms blank
            //trialTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { (trialTimer) in self.displayBlank() })
            displayBlank()
        }
    }
    
    func displayFixation() {
        fixationCross.isHidden = false
        stimImage.isHidden = true
        boarderView.isHidden = true
        setButtonVisibility(isHidden: true)
        usleep(1400000)     //  This is intentional locking (1.4s)
    }
    
    func displayTrial() {
        fixationCross.isHidden = true
        stimImage.isHidden = false
        setBoarder(isAboveBelow: (block!.trials![trialIndex].isAboveBelow)!)
        setButtonVisibility(isHidden: false)
        usleep(3000000)     //  This is intentional locking (.025s)
    }
    
    func displayBlank() {
        self.fixationCross.isHidden = true
        self.stimImage.isHidden = true
        self.boarderView.isHidden = true
        self.setButtonVisibility(isHidden: true)
        usleep(25000)     //  This is intentional locking (.025s)
        self.currentTrial = self.currentTrial + 1
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
            boarderView.isHidden = false
        } else {
            boarderView.isHidden = true
        }
    }
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("The sender is \(sender as! BlockType)")
    }
 */
}
