//
//  PreviewHelper.swift
//  IncomeApp
//
//  Created by MAC on 27/04/2025.
//

import Foundation
import SwiftData

@MainActor
class PreviewHelper{
    static let previewContainer: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do{
            let container = try ModelContainer(for: TransactionData.self, configurations: config)
            let transaction = TransactionData(id: UUID(), title: "Rent", date: Date.now, type: .income, amount: 200)
            container.mainContext.insert(transaction)
            return container
        }catch {
            fatalError("Failed to create model container")
        }
    }()
    
    
}
