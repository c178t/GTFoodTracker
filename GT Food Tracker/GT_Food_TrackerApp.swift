//
//  GT_Food_TrackerApp.swift
//  GT Food Tracker
//
//  Created by Cian Thomas on 7/1/24.
//

import SwiftUI
import SwiftData

@main
struct GT_Food_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TrackerView()
        }
        .modelContainer(for: Account.self)
    }
}
