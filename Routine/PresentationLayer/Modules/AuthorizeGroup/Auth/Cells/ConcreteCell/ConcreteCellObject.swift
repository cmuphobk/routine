//
//  ConcreteCellObject.swift
//  HCulture
//
//  Created by Vitaly Volodin on 17.10.2018.
//  Copyright © 2018 BaccaSoft. All rights reserved.
//

import UIKit

class ConcreteCellObject {
    fileprivate let paddingLeft: CGFloat = 16.0
    fileprivate let paddingRight: CGFloat = 16.0
    fileprivate let paddingTop: CGFloat = 16.0
    fileprivate let paddingBottom: CGFloat = 16.0
    fileprivate let constraintBetweenTopAndSubText: CGFloat = 8.0
    
    let topTextString: String
    let topTextFont: UIFont = UIFont.DefaultTheme.topText
    let subTextString: String
    let subTextFont: UIFont = UIFont.DefaultTheme.subText
    
    init(topTextString: String, subTextString: String) {
        self.topTextString = topTextString
        self.subTextString = subTextString
    }
}

extension ConcreteCellObject: CellObjectSizer {
    func calcHeightWithCellWidth(_ cellWidth: CGFloat) -> CGFloat {
        let topTextHeight = self.topTextFont.sizeOfString(string: String.localizeById(self.topTextString), constrainedToWidth: Double(cellWidth - (self.paddingLeft + self.paddingRight))).height
        let subTextHeight = self.subTextFont.sizeOfString(string: String.localizeById(self.subTextString), constrainedToWidth: Double(cellWidth - (self.paddingLeft + self.paddingRight))).height
        return self.paddingTop + topTextHeight + self.constraintBetweenTopAndSubText + subTextHeight + self.paddingBottom
    }
    
    func calcExpandableHeightWithCellWidth(_ cellWidth: CGFloat) -> CGFloat {
        return self.calcHeightWithCellWidth(cellWidth)
    }
}
