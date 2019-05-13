//
//  RoutineLocalize.swift
//  Routine
//
//  Created by Кирилл Смирнов on 11/05/2019.
//  Copyright © 2019 hculture. All rights reserved.
//

import Foundation

protocol RoutineDelegate: class {
    func localize(_ text: String) -> String
}
