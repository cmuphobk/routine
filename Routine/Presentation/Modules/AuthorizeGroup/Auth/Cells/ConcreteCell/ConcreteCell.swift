//
//  ConcreteCell.swift
//  HCulture
//
//  Created by Vitaly Volodin on 17.10.2018.
//  Copyright © 2018 BaccaSoft. All rights reserved.
//

import UIKit

class ConcreteCell: LocalizedTableViewCell<ConcreteCellObject> {
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!

    override func configure(cellObject: ConcreteCellObject) {
        super.configure(cellObject: cellObject)

        self.topLabel.font = self.cellObject.topTextFont
        self.topLabel.textColor = UIColor.DefaultTheme.blackColor
        self.subLabel.font = self.cellObject.subTextFont
        self.subLabel.textColor = UIColor.DefaultTheme.blackColor
    }

    override func localizationSetup() {
        self.topLabel.text = self.cellObject.topTextString
        self.subLabel.text = self.cellObject.subTextString
    }
}
