//
//  SignUpViewController.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-19.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class SignUpViewController: UIViewController,UITextFieldDelegate {

    let mainDelegate=UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      styleMyElements()
        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String?
    {
        if(txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            txtEmailAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ){
            return "Text Fields  cannot be empty !"
        }
        
        if(!(Utilities.isPasswordValid((txtPassword.text)!)))
        {
           return " Password is not secure !"
        }
        
        return nil
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        let error=self.validateFields()
        if(error != nil)
        {
            showError(error: error!)
            
        }
        else{
            
            let firstName=txtFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName=txtLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email=txtEmailAddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password=txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            Auth.auth().createUser(withEmail: email, password:password) { (result,err) in
                
               if(err != nil)
               {
                   self.showError(error: "Error creating user ")
                }
                else
               {
                              let db=Firestore.firestore()
                
                            let uName=result?.user.uid
                
                            db.collection("users").document(uName!).setData(["first_name":firstName,"last_name":lastName,"email":email,"password":password,"uid":result!.user.uid], completion: { (error) in
                                if error != nil
                                {
                                    self.showError(error: " Error saving user data")
                                }
                                else
                                {
                                         self.mainDelegate.userId=uName!
                                      self.swichToHomeScreen()
                                }
                                
                                
                           
                            })
      
             
                 }
                
            }
    }
    }
    
    
    
    func showError(error:String)
    {
        lblError.text=error
        lblError.alpha=1
    }
    
    func styleMyElements()
    {
        lblError.alpha=0.0
        Utilities.styleTextField(txtFirstName)
        Utilities.styleTextField(txtLastName)
        Utilities.styleTextField(txtEmailAddress)
        Utilities.styleTextField(txtPassword)
        Utilities.styleFilledButton(btnSignUp)
       
    }

    
    func swichToHomeScreen()
    {
        let homeVc=storyboard?.instantiateViewController(withIdentifier: "homeVc")
        view.window?.rootViewController=homeVc
        view.window?.makeKeyAndVisible()
    }

}

