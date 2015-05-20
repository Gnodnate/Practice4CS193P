//
//  ViewController.swift
//  DropIt
//
//  Created by Dan Tan on 5/19/15.
//  Copyright (c) 2015 Destiny. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController, UIDynamicAnimatorDelegate {

    @IBOutlet weak var gameView: UIView!
    var dropsPerRow = 10
    var dropSize:CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator
    }()
    
    let dropItBehavior = DropItBehavior()

    var lastDroppedItem: UIView?
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func drop() {
        var frame = CGRect(origin: CGPoint.zeroPoint, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        let dropItem = UIView(frame: frame)
        dropItem.backgroundColor = UIColor.randomColor()
        lastDroppedItem = dropItem
        dropItBehavior.addDrop(dropItem)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropItBehavior)
    }
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    func removeCompletedRow()
    {
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
        
        do {
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            var dropsFound = [UIView]()
            var rowIsComplete = true
            for _ in 0 ..< dropsPerRow {
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), withEvent: nil) {
                    if hitView.superview == gameView {
                        dropsFound.append(hitView)
                    } else {
                        rowIsComplete = false
                    }
                }
                dropFrame.origin.x += dropSize.width
            }
            if rowIsComplete {
                dropsToRemove += dropsFound
            }
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        
        for drop in dropsToRemove {
            dropItBehavior.removeDrop(drop)
        }
    }
}

private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor {
    static func randomColor() -> UIColor {
        var red = CGFloat(arc4random())/(CGFloat(RAND_MAX)*2)
        var green = CGFloat(arc4random())/(CGFloat(RAND_MAX)*2)
        var blue = CGFloat(arc4random())/(CGFloat(RAND_MAX)*2)
//        println("red:\(red), green\(green), blue:\(blue)")
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
