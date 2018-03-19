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
        performSegue(withIdentifier: "presentBlock", sender: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }

}

