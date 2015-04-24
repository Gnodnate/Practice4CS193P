//
//  TextViewController.swift
//  Psychologist
//
//  Created by Dan Tan on 4/24/15.
//  Copyright (c) 2015 Destiny. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    var text:String = "" {
        didSet {
            textView?.text = text
        }
    }
    
//    override var preferredContentSize:CGSize {
//    
//        get {
//            if nil != textView && nil != presentingViewController  {
//                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
//            } else {
//                return super.preferredContentSize
//            }
//        }
//        
//        set { super.preferredContentSize = newValue }
//    }
}
