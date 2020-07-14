//
//  BudgetViewController.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-20.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import Firebase
class BudgetViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{

    let category:Array<String>=["Choose Budget Category","Food","Entertainment","Grocery","Gasoline","Clothes","Gifts"]
    
    var selectedCategory:String?
    let mainDelegate=UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet var txtAmount:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCategory=category[row]
        
    }
    
    func addBudget() {
        
        let amount:Double=Double(txtAmount.text!) as! Double
        let currentDate:Date=Date()
        let lmtDate:Date=Date(timeInterval: 2.628e+6, since: currentDate)
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let cDate=formatter.string(from: currentDate)
        let lDate=formatter.string(from: lmtDate)
        print(cDate)
        print(lDate)
    
        
        
        let db=Firestore.firestore()
        db.collection("Budgets").document(mainDelegate.userId).setData(["\(self.selectedCategory!)":amount,"AddedTime\(self.selectedCategory!)":cDate,"ExpireTime\(self.selectedCategory!)":lDate],merge:true, completion: { (error) in
            if error != nil
            {
               print("ERROR SAVING DATA")
            }
            else
            {
                let alertBox=UIAlertController(title:" Budget Successfully Added", message:"Budget for \(self.selectedCategory!) for amount : $ \(amount) has been created for 1 month  ", preferredStyle: .alert)
                
                let cancelButton=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertBox.addAction(cancelButton)
                self.present(alertBox,animated: true)
            }
        })
    }
                
       
        
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
   @IBAction func checkIfBudgetExists()
    {
     
        let db=Firestore.firestore()
       let docRef = db.collection("Budgets").document(mainDelegate.userId)
        
        docRef.getDocument { (document, error) in
            
            if let document = document, document.exists {
               
                let mDic=document.data()
                
                if mDic![self.selectedCategory!] != nil
                {
                    print("Budget for the category already exists ..")
                  
                    let alertBox=UIAlertController(title:" Budget not added !", message:"Sorry the Budget already exists for the category !", preferredStyle: .alert)
                    let cancelButton=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let updateButton=UIAlertAction(title: "Update", style:.default, handler: { (alert) in
                        self.addBudget()
                    })
                    alertBox.addAction(cancelButton)
                    alertBox.addAction(updateButton)
                    self.present(alertBox,animated: true)
                    
                    
                }
                else
                {
                   self.addBudget()
                }
            }
            else {
                print("Document does not exist")
                self.addBudget()
              
           
            }
          
        }
       
       
    }
    
    @IBAction func unwindToBudgetViewController(sender:UIStoryboardSegue)
    {
        
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
