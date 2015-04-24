//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Dan Tan on 4/24/15.
//  Copyright (c) 2015 Destiny. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    var diagnosticHistory : [Int] {
        get  {
            return defaults.valueForKey(StoryBoard.DefaultKey) as? [Int] ?? []
        }
        
        set {
            defaults.setObject(newValue, forKey: StoryBoard.DefaultKey)
        }
    }
    
    struct StoryBoard{
        static let SegueIdentifier = "Show History"
        static let DefaultKey = "DiagoseHappinessViewController.history"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case StoryBoard.SegueIdentifier:
//                var destintation = segue.destinationViewController as? UIViewController
//                if let navCon = destintation as? UINavigationController {
//                    destintation = navCon.visibleViewController
//                }
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.FullScreen
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        var nav = UINavigationController(rootViewController: controller.presentedViewController)
        var bbi = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "dismiss")
        controller.presentedViewController.navigationItem.leftBarButtonItem = bbi
        return nav
    }
 
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
