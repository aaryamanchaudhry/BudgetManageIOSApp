//
//  HomeViewController.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-19.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    let mainDelegate=UIApplication.shared.delegate as! AppDelegate

    
    @IBOutlet var lblUser:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      let db = Firestore.firestore()
    

        let docRef = db.collection("users").document(mainDelegate.userId)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let fName:String=document.data()!["first_name"] as! String
                self.lblUser.text=fName
               
            } else {
                print("Document does not exist")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToHomeVc(sender:UIStoryboardSegue)
    {
        
    }
    

    @IBAction func logOutTapped(_ sender: Any) {
        
        let auth=Auth.auth()
        
        do
        {
           try auth.signOut()
         
            let rootVc=storyboard?.instantiateViewController(withIdentifier: "rootVc")
            view.window?.rootViewController=rootVc
            view.window?.makeKeyAndVisible()
            
        
            
        }catch let signOutError  {
            
           print("Sign out failed ")
        }
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
