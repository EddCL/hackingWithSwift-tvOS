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
        
    }

    @IBAction func showAlert(_ sender: UIButton) {
    }
    
}

