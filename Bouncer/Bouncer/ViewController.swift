//
//  ViewController.swift
//  Bouncer
//
//  Created by Dan Tan on 5/20/15.
//  Copyright (c) 2015 Dan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bouncer = BouncerBehavior()
    lazy var animator: UIDynamicAnimator = { UIDynamicAnimator(referenceView: self.view) } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(bouncer)
    }
    
    var blueBlock: UIView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if blueBlock == nil {
            blueBlock = addBlock()
            blueBlock?.backgroundColor = UIColor.blueColor()
            bouncer.addBlock(blueBlock!)
        }
        
        let motionManager = AppDelegate.Motion.Mamager
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
                (data, error) -> Void in
                self.bouncer.gravity.gravityDirection = CGVector(dx: data.acceleration.x, dy: -data.acceleration.y)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.Motion.Mamager.stopAccelerometerUpdates()
    }
    
    struct Constrants {
        static let BlockSize = CGSize(width: 40, height: 40)
    }
    func addBlock() -> UIView {
        let block = UIView(frame: CGRect(origin: CGPoint.zeroPoint, size: Constrants.BlockSize))
        block.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(block)
        return block
    }

}

