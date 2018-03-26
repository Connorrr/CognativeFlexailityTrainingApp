//
//  ViewController.swift
//  CognativeFlexabilityTraining
//
//  Created by Connor Reid on 15/3/18.
//  Copyright © 2018 Connor Reid. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextViewDelegate {
    
    let experimentStructure : [BlockType] = [.practice,.single,.single,.mixed,.mixed,.single,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed]
    
    var blockProgress : Int = 0
    var instructionsState : InstructionsTextState?

    @IBOutlet weak var instructionsTextView: InstructionsTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        instructionsTextView.addGestureRecognizer(tapRecognizer)
        
        if instructionsState == nil {
            instructionsState = .openingText
        }
        
        switch instructionsState! {
        case .openingText:
            print("Opening Text")
            setText("Opening")
        case .breakText:
            print("Break Text")
            setText("Break")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func viewTapped() {
        performSegue(withIdentifier: "presentBlock", sender: experimentStructure[blockProgress])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentBlock" {
            if let blockViewController = segue.destination as? BlockViewController {
                blockViewController.blockType = experimentStructure[blockProgress]
            }
        }
    }
    
    // Returns true if succeeded
    @discardableResult func setText(_ fName:  String) -> Bool{
        let url = Bundle.main.url(forResource: fName, withExtension: "html")
        if (url == nil){
            print("Where dat Url @ brah!")
            return false
        }
        var d : NSDictionary? = nil
        let s = try! NSAttributedString(url: url!, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: &d)
        dump(s)
        self.instructionsTextView.attributedText = s
        self.instructionsTextView.font = UIFont(name: "Helvetica", size: 24)
        return true
    }

}

