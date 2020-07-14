//
//  SiteCellTableViewCell.swift
//  W8TablePart1
//
//  Created by Xcode User on 2020-03-05.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class SiteCellTableViewCell: UITableViewCell {

    let categoryLabel=UILabel()
    let amountLabel=UILabel()
    let createTimeLabel=UILabel()
    let lmtTimeLabel=UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        categoryLabel.textAlignment = .left
        categoryLabel.font=UIFont.boldSystemFont(ofSize: 30)
        categoryLabel.backgroundColor = .clear
        categoryLabel.textColor = .black
        
        amountLabel.textAlignment = .left
        amountLabel.backgroundColor = .clear
        amountLabel.textColor = .blue
        amountLabel.font=UIFont.boldSystemFont(ofSize: 20)
        
        createTimeLabel.textAlignment = .left
        createTimeLabel.backgroundColor = .clear
        createTimeLabel.textColor = .blue
        createTimeLabel.font=UIFont.boldSystemFont(ofSize: 20)
        
        lmtTimeLabel.textAlignment = .left
        lmtTimeLabel.backgroundColor = .clear
        lmtTimeLabel.textColor = .blue
        lmtTimeLabel.font=UIFont.boldSystemFont(ofSize: 20)
        
        
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(createTimeLabel)
        contentView.addSubview(lmtTimeLabel)
        
        
        
        
        
    }
    
    override func layoutSubviews() {
        categoryLabel.frame=CGRect(x:15, y:5, width:460, height:30)
        amountLabel.frame=CGRect(x:230,y:5,width:460,height: 20)
        createTimeLabel.frame=CGRect(x:15, y:45, width:445,height:45)
        lmtTimeLabel.frame=CGRect(x:250, y:45, width:445,height:45)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
