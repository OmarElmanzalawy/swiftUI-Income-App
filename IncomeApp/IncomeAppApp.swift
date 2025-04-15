//
//  IncomeAppApp.swift
//  IncomeApp
//
//  Created by MAC on 19/03/2025.
//

import SwiftUI

@main
struct IncomeAppApp: App {
    
    let dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}
