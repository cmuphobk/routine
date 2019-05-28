//
//  LocalizedUrl.swift
//  EurasianEconomicUnion
//
//  Created by Кирилл Смирнов on 14.09.2018.
//  Copyright © 2018 bacca. All rights reserved.
//

import Foundation

class LocalizedUrl {
    let rus: String
    let eng: String

    subscript(index: String) -> String {
        switch index {
        case "ru": return self.rus
        case "en": return self.eng

        default: return self.en
        }
    }

    init(rus: String, eng: String) {
        self.rus = URL.hostURL() + rus
        self.eng = URL.hostURL() + eng
    }
}
