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
    var pressCalculateOnce: Bool
    var excludedDays: [Int]
    var sundayBool: Bool
    var mondayBool: Bool
    var tuesdayBool: Bool
    var wednesdayBool: Bool
    var thursdayBool: Bool
    var fridayBool: Bool
    var saturdayBool: Bool
    
    init(balance: Int? = 0, frequency: Int, endDate: String, pressCalculateOnce: Bool, excludedDays: [Int], sundayBool: Bool, mondayBool: Bool, tuesdayBool: Bool, wednesdayBool: Bool, thursdayBool: Bool, fridayBool: Bool, saturdayBool: Bool) {
        self.balance = balance
        self.frequency = frequency
        self.endDate = endDate
        self.pressCalculateOnce = pressCalculateOnce
        self.excludedDays = excludedDays
        self.sundayBool = sundayBool
        self.mondayBool = mondayBool
        self.tuesdayBool = tuesdayBool
        self.wednesdayBool = wednesdayBool
        self.thursdayBool = thursdayBool
        self.fridayBool = fridayBool
        self.saturdayBool = saturdayBool
    }
    
}
