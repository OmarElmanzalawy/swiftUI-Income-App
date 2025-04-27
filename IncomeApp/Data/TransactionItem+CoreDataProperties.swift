//
//  TransactionItem+CoreDataProperties.swift
//  IncomeApp
//
//  Created by MAC on 13/04/2025.
//
//

import Foundation
import CoreData


extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var amount: Double
    @NSManaged public var type: Int16

}

extension TransactionItem : Identifiable {

}

extension TransactionItem{
    var wrappedId: UUID{
        return id!
    }
    var wrappedTitle: String{
        return title ?? ""
    }
    var wrappedDate: Date{
        return date ?? Date.now
    }
    var wrappedAmount: Double{
        return amount ?? 0.0
    }
    var wrappedType: TransactionType{
        return TransactionType(rawValue: Int(type)) ?? .expense
    }
}
