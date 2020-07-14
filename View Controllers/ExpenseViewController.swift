//
//  ExpenseViewController.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-23.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import Firebase
class ExpenseViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{

    let mainDelegate=UIApplication.shared.delegate as! AppDelegate
    var myExpenses:Array<Expense>=[]
    @IBOutlet weak var txtAmount: UITextField!
    let category:Array<String>=["Choose Budget Category","Food","Entertainment","Grocery","Gasoline","Clothes","Gifts"]
    
    var selectedCategory:String=""
    @IBOutlet var dateSelected:UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.category[row]
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCategory=self.category[row]
    }
    
    

    @IBAction func addExpense(_ sender: Any) {
        
        let amount:Double=Double(txtAmount.text!) as! Double
       
        let datePicked:Date=self.dateSelected.date
        
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dp:String=formatter.string(from: datePicked)
        
        
        print("Selected Category : \(self.selectedCategory) \n Selected Amount: \(amount) \n Date Added : \(dp) \n")
        
        let expense:Expense=Expense.init()
        
        expense.initWithData(self.selectedCategory,amount, dp)
        myExpenses.append(expense)
          let db=Firestore.firestore()

     db.collection("Expenses").document(mainDelegate.userId).setData(["ekdl":myExpenses],merge:true, completion: { (error) in
            if error != nil
          {
                print("ERROR SAVING DATA")
            }
            else
           {
                let alertBox=UIAlertController(title:" Expense Successfully Added", message:"Expense for \(self.selectedCategory) for amount : $ \(amount) has been added ", preferredStyle: .alert)

                let cancelButton=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
               alertBox.addAction(cancelButton)
              self.present(alertBox,animated: true)
            
        }
       })
        
        
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
