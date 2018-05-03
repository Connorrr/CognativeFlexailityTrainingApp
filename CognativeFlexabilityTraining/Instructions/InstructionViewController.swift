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
    
    let experimentStructure : [BlockType] = [.practice,.practice]//,.single,.single,.mixed,.mixed,.single,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed,.single,.mixed,.mixed] TODO: Remove this before I finish
    
    var blockProgress : Int = 0
    var instructionsState : InstructionsTextState?
    
    var logFileMaker : LogFileMaker?
    var fileName : String?

    @IBOutlet weak var instructionsTextView: InstructionsTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LogFileMaker = LogFileMaker(fileName: "\(fileName!)-\(getDateString)")
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        instructionsTextView.addGestureRecognizer(tapRecognizer)
        
        if instructionsState == nil {
            instructionsState = .openingText
        }
        
        switch instructionsState! {
        case .openingText:
            setText("Opening")
        case .breakText:
            setText("Break")
        case .goodbyeText:
            setText("Goodbye")
            if !logFileMaker.saveData() {
                print("Error:  Unable to save the log file data")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDateString () -> String {
        let date = NSDate()
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.stringFromDate(date)
    }
    
    @objc func viewTapped() {
        if instructionsState! == .goodbyeText {
            performSegue(withIdentifier: "instructionsToLogin", sender: nil)
        }else{
            performSegue(withIdentifier: "presentBlock", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentBlock" {
            if let blockViewController = segue.destination as? BlockViewController {
                blockViewController.blockType = experimentStructure[blockProgress]  // TODO:  Change this for the final page
                blockViewController.blockProgress = blockProgress
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
        self.instructionsTextView.attributedText = s
        self.instructionsTextView.font = UIFont(name: "Helvetica", size: 24)
        return true
    }

}

