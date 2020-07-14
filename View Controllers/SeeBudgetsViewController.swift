//
//  SeeBudgetsViewController.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-22.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import Firebase
class SeeBudgetsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let mainDelegate=UIApplication.shared.delegate as! AppDelegate
    let category:Array<String>=["Choose Budget Category","Food","Entertainment","Grocery","Gasoline","Clothes","Gifts"]
    
    @IBOutlet var myTableView:UITableView!
   
    var myBudgets:Array<Budget>=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateMyBudgets()
       
}
        
        
        

        // Do any additional setup after loading the view.
    
    
    
  
   
    func updateMyBudgets()
    {
        
        let db=Firestore.firestore()
        let docRef=db.collection("Budgets").document(mainDelegate.userId)
        
        docRef.getDocument { (document, error) in
            
            if let document=document, document.exists
            {
                                let myDoc=document.data()
                
                                let myKeys:Array<String>=Array(myDoc!.keys)
                
                                let tmpArray:Array<String> = self.category.filter(myKeys.contains)
                
                                var selectedAmount:Double?
                                var selectedCategory:String?
                                var bgtCreateTime:String?
                                var bgtlmtTime:String?
                
                                for some in tmpArray
                                {
                                    print(some)
                                    selectedAmount=((myDoc![some])as! Double)
                                    print(selectedAmount!)
                                    selectedCategory=some
                                    print(selectedCategory!)
                                    bgtCreateTime=(myDoc!["AddedTime\(some)"] as! String)
                                    print(bgtCreateTime!)
                                    bgtlmtTime=(myDoc!["ExpireTime\(some)"] as! String)
                                    print(bgtlmtTime!)
                                    var budget=Budget.init()
                                    budget.initWithData(selectedCategory!, selectedAmount!, bgtCreateTime!, bgtlmtTime!)
                                    self.myBudgets.append(budget)
                                    
                                    
                                }
                
                
                
                                print("Budget count in view did load method \(self.myBudgets.count)")
                                self.myTableView.reloadData()
                
                
                
                }
                else
                {
                print("DOC DOES NOT EXIST !")
                }
        }
            
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          print("Budget count in table method \(self.myBudgets.count)")
        return self.myBudgets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let tableCell=UITableViewCell(style: .default, reuseIdentifier: "cell") as? SiteCellTableViewCell ?? SiteCellTableViewCell(style: .default, reuseIdentifier: "cell")
        let rowNum=indexPath.row
        tableCell.categoryLabel.text=self.myBudgets[rowNum].selectedCategory!
        tableCell.amountLabel.text="$ \(String(self.myBudgets[rowNum].selectedAmount!))"
        tableCell.createTimeLabel.text=self.myBudgets[rowNum].bgtCreateTime!
        tableCell.lmtTimeLabel.text=self.myBudgets[rowNum].bgtLimitTime!
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
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
