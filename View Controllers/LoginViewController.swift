//
//  LoginViewController.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-19.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController,UITextFieldDelegate {

    let mainDelegate=UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        styleMyElements()
        // Do any additional setup after loading the view.
    }
    func validateFields() -> String?
    {
        if(txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ){
            return "Text Fields  cannot be empty !"
        }
        
        
        
        return nil
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
      
        let error=self.validateFields()
        if(error != nil)
        {
            self.showError(error: error!)
        }
        else{
            let email=txtEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password=txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password){ (result,err) in
                
                if(err !=  nil)
                {
                   self.showError(error: err!.localizedDescription)
                    
                }
                else
                {
                    let userID=result!.user.uid
                    self.mainDelegate.userId=userID
                    let homeVc=self.storyboard?.instantiateViewController(withIdentifier: "homeVc")
                    self.view.window?.rootViewController=homeVc
                    self.view.window?.makeKeyAndVisible()
                 
                    
                }
            }
        }
       
    }
    
    func styleMyElements()
    {
        lblError.alpha=0.0
        Utilities.styleTextField(txtPassword)
        Utilities.styleTextField(txtEmail)
        Utilities.styleFilledButton(btnLogin)
    }
    func showError(error:String)
    {
        lblError.text=error
        lblError.alpha=1
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
