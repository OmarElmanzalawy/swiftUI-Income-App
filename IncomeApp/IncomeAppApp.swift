//
//  IncomeAppApp.swift
//  IncomeApp
//
//  Created by MAC on 19/03/2025.
//

import SwiftUI
import SwiftData

@main
struct IncomeAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [TransactionData.self])
        }
    }
}
