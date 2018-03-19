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
    
    var blockType : BlockType?
    var block : Block?
    
    override func viewWillAppear(_ animated: Bool) {
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
            questionLabel.text = block?.trials?[0].question
            stimImage.image = block?.trials?[0].stim
        }else{
            questionLabel.text = "ERROR"
        }
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func greaterThanButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func lessThanButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func evenButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func oddButtonPressed(_ sender: UIButton) {
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
