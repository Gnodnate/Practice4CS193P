//
//  DropItBehavior.swift
//  DropIt
//
//  Created by Dan Tan on 5/20/15.
//  Copyright (c) 2015 Destiny. All rights reserved.
//

import UIKit

class DropItBehavior: UIDynamicBehavior {
    
    
    let gravity = UIGravityBehavior()
    
    lazy var collider: UICollisionBehavior = {
       let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    }()
    
    lazy var dropBehavior: UIDynamicItemBehavior = {
       let lazilyCreatedDropBehavior = UIDynamicItemBehavior()
        lazilyCreatedDropBehavior.allowsRotation = true
        lazilyCreatedDropBehavior.elasticity = 0.85
        return lazilyCreatedDropBehavior
    }()
    
    override init(){
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropBehavior)
        
    }
    
    func addDrop(dropItem: UIView) {
        dynamicAnimator?.referenceView?.addSubview(dropItem)
        gravity.addItem(dropItem)
        collider.addItem(dropItem)
        dropBehavior.addItem(dropItem)
    }
    
    func removeDrop(dropItem: UIView) {
        gravity.removeItem(dropItem)
        collider.removeItem(dropItem)
        dropBehavior.removeItem(dropItem)
        dropItem.removeFromSuperview()
    }
    
    
   
}
