//
//  ConcreteHeaderCellObject.swift
//  HCulture
//
//  Created by Vitaly Volodin on 17.10.2018.
//  Copyright © 2018 BaccaSoft. All rights reserved.
//

import UIKit

class ConcreteHeaderCellObject {
    fileprivate let paddingLeft: CGFloat = 16.0
    fileprivate let paddingRight: CGFloat = 16.0
    fileprivate let paddingTop: CGFloat = 16.0
    fileprivate let paddingBottom: CGFloat = 16.0
    
    let headerString: String
    let headerFont: UIFont = UIFont.DefaultTheme.concreteHeader
    
    init(header: String) {
        self.headerString = header
    }
}

extension ConcreteHeaderCellObject: CellObjectSizer {
    func calcHeightWithCellWidth(_ cellWidth: CGFloat) -> CGFloat {
        let headerHeight = self.headerFont.sizeOfString(string: String.localizeById(self.headerString), constrainedToWidth: Double(cellWidth - (self.paddingLeft + self.paddingRight))).height
        return self.paddingTop + headerHeight + self.paddingBottom
    }
    
    func calcExpandableHeightWithCellWidth(_ cellWidth: CGFloat) -> CGFloat {
        return self.calcHeightWithCellWidth(cellWidth)
    }
}
