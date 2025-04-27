//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by MAC on 19/03/2025.
//

import Foundation
import SwiftData

@Model class TransactionData{
    var id : UUID = UUID()
    var title: String = ""
    var date: Date = Date.now
    var type: TransactionType = TransactionType.expense
    var amount: Double = 0
    
    init(id: UUID, title: String, date: Date, type: TransactionType, amount: Double) {
        self.id = id
        self.title = title
        self.date = date
        self.type = type
        self.amount = amount
    }
    
    @Transient
    var displayDate: String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    @Transient
    func displayAmount(currency: Currency) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = currency.locale
        formatter.maximumFractionDigits = 2
        return formatter.string(from: amount as NSNumber) ?? "$0.00"
    }
}

//struct TransactionModel: Identifiable,Hashable{
//    let id = UUID()
//    let title: String
//    let date: Date
//    let type: TransactionType
//    let amount: Double
//    
//    var displayDate: String{
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        return formatter.string(from: date)
//    }
//    
//    func displayAmount(currency: Currency) -> String{
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.locale = currency.locale
//        formatter.maximumFractionDigits = 2
//        return formatter.string(from: amount as NSNumber) ?? "$0.00"
//    }
//}
