//
//  ViewController.swift
//  AutoLayout
//
//  Created by Dan Tan on 4/27/15.
//  Copyright (c) 2015 Destiny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    var secure = false { didSet { updateUI() } }

    var loggedInUser: User? { didSet { updateUI() } }
    
    private var image: UIImage? {
        get {
            return imageView?.image
        }
        set {
            imageView?.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                } else {
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    
    private var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioConstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
        
        
    }
    
    @IBAction func toggleChange() {
        secure = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(userNameField.text, password: passwordField.text)
    }
    
}

extension User {
    var image: UIImage? {
        get {
            if let image = UIImage(named: login)
            {
                return image
            } else {
                return UIImage(named: "unknown_user")
            }
        }
    }
}

extension UIImage {
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width/size.height : 0
    }
}



