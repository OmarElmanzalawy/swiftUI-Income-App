

import Foundation
import CoreData

class DataManager{
    
    let container = NSPersistentContainer(name: "IncomeData")
    static let shared = DataManager()
    static var sharedPreview: DataManager = {
        let manager = DataManager(inMemory: true)
        return manager
    }()
    //inMemory is used to store data in memory instead of storing it presistently (used for previews)
    private init(inMemory: Bool = false){
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
