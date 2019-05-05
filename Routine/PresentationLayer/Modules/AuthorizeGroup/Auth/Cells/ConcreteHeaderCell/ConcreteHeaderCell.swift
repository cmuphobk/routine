//
//  ConcreteHeaderCell.swift
//  HCulture
//
//  Created by Vitaly Volodin on 17.10.2018.
//  Copyright © 2018 BaccaSoft. All rights reserved.
//

import UIKit

class ConcreteHeaderCell: LocalizedTableViewCell<ConcreteHeaderCellObject> {
    @IBOutlet weak var headerLabel: UILabel!
    
    override func configure(cellObject: ConcreteHeaderCellObject) {
        super.configure(cellObject: cellObject)
        
        self.headerLabel.font = self.cellObject.headerFont
        self.headerLabel.textColor = UIColor.DefaultTheme.blackColor
    }
    
    override func localizationSetup() {
        self.headerLabel.text = self.cellObject.headerString
    }
}
