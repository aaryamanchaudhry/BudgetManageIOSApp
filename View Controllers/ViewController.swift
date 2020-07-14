//
//  ViewController.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-19.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btnSignUp:UIButton!
    @IBOutlet var btnLogin:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.styleMyElements()
    }
    
    func styleMyElements()
    {
       Utilities.styleFilledButton(btnSignUp)
       Utilities.styleHollowButton(btnLogin)
    }
    
    @IBAction func unwindToVC(sender:UIStoryboardSegue){
        
    }


}

