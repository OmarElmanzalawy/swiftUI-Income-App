//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by MAC on 19/03/2025.
//

import Foundation

struct TransactionModel: Identifiable,Hashable{
    let id = UUID()
    let title: String
    let date: Date
    let type: TransactionType
    let amount: Double
    
    var displayDate: String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
//    var displayAmount: String{
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.maximumFractionDigits = 2
//        return formatter.string(from: amount as NSNumber) ?? "$0.00"
//    }
//    
    func displayAmount(currency: Currency) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = currency.locale
        formatter.maximumFractionDigits = 2
        return formatter.string(from: amount as NSNumber) ?? "$0.00"
    }
}
