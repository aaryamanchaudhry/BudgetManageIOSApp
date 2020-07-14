//
//  Expense.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-23.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class Expense: NSObject {
    
    var selectedCategory:String?
    var selectedAmount:Double?
    var transactionTime:String?
    
    func initWithData(_ selectedCategory:String, _ selectedAmount:Double, _ transactionTime:String)
    {
        self.selectedCategory=selectedCategory
        self.selectedAmount=selectedAmount
        self.transactionTime=transactionTime
    }

}
