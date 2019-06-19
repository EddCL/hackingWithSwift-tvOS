//
//  ViewController.swift
//  Project3
//
//  Created by Eduardo Carrillo on 6/19/19.
//  Copyright © 2019 Eduardo Carrillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var textFieldTip: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    var focusGuide: UIFocusGuide!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        
        focusGuide.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        focusGuide.preferredFocusEnvironments = [nextButton]
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        //if moving towards the text field
        if context.nextFocusedView == textField{
            //tell to redirect to next button
            focusGuide.preferredFocusEnvironments = [nextButton]
        } else if context.nextFocusedView == nextButton {
            //tell to redirect to text field
            focusGuide.preferredFocusEnvironments = [textField]
        }
    }
    
    

    //p192
    
    @IBAction func showAlert(_ sender: UIButton) {
    }
    
}

