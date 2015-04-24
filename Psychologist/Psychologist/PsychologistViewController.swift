//
//  ViewController.swift
//  Psychologist
//
//  Created by Dan Tan on 4/24/15.
//  Copyright (c) 2015 Destiny. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nothing(sender: AnyObject) {
        performSegueWithIdentifier("nothing", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var destintation = segue.destinationViewController as? UIViewController
        if let navCon = destintation as? UINavigationController {
            destintation = navCon.visibleViewController
        }
        
        if let hvc = destintation as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "sad": hvc.happiness = 0
                case "happy": hvc.happiness = 100
                case "nothing":hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }
}

