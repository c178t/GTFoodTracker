//
//  Account.swift
//  GT Food Tracker
//
//  Created by Cian Thomas on 8/1/24.
//

import Foundation
import SwiftData

@Model
class Account {
    var balance: Int?
    var frequency: Int
    var endDate: String
    var pressCalculationsOnce: Bool
    var excludedDays: [Int]
    
    init(balance: Int? = 0, frequency: Int = 1, endDate: String = "", pressCalculationsOnce: Bool = false, excludedDays: [Int] = []) {
        self.balance = balance
        self.frequency = frequency
        self.endDate = endDate
        self.pressCalculationsOnce = pressCalculationsOnce
        self.excludedDays = excludedDays
    }
    
}
