//
//  Budget.swift
//  IOSFinalProject
//
//  Created by Xcode User on 2020-03-22.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class Budget: NSObject {
    
    var selectedCategory:String?
    var selectedAmount:Double?
    var bgtCreateTime:String?
    var bgtLimitTime:String?
    
    func initWithData(_ selectedCategory:String,_ selectedAmount:Double, _ bgtCreateTime:String,_ bgtLimitTime:String)
    {
        self.selectedAmount=selectedAmount
        self.selectedCategory=selectedCategory
        self.bgtLimitTime=bgtLimitTime
        self.bgtCreateTime=bgtCreateTime
    }

}
