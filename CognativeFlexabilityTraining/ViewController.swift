//
//  ViewController.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    let experimentStructure : [BlockType] = [.practice,.single,.single,.mixed,.mixed,.single,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed]
    
    var blockProgress : Int = 0

    @IBOutlet weak var instructionsTextView: InstructionsTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("The text field was touched up")
        performSegue(withIdentifier: "presentBlock", sender: experimentStructure[blockProgress])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentBlock" {
            if let blockViewController = segue.destination as? BlockViewController {
                blockViewController.blockType = experimentStructure[blockProgress]
            }
        }
    }

}

