//
//  enums.swift
//  IncomeApp
//
//  Created by MAC on 19/03/2025.
//

import Foundation

enum TransactionType: Int, CaseIterable, Identifiable{
    case income,expense
    var id: Self {self}
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}

enum Currency: Int,CaseIterable{
    case usd,egyptian,euros
    
    var title: String{
        switch self {
        case .usd:
            return "$"
        case .egyptian:
            return "EGP"
        case .euros:
            return "£"
        }
    }
    
    var locale: Locale{
        switch self {
        case .usd:
            return Locale(identifier: "en_US")
        case .egyptian:
            return Locale(identifier: "egp")
        case .euros:
            return Locale(identifier: "en_GB")
        }
    }
}
