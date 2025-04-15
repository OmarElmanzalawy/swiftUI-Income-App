//
//  DataManager.swift
//  IncomeApp
//
//  Created by MAC on 13/04/2025.
//

import Foundation
import CoreData

class DataManager{
    
    let container = NSPersistentContainer(name: "IncomeData")
    static let shared = DataManager()
    
   private init(){
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
