//
//  DatabaseManager.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 10.12.2022.
//


import Foundation
import CoreData

protocol IStorageManager: AnyObject {
    func saveResult(result: BlazrResult, with context: NSManagedObjectContext, completionHandler: FinishedCompletionHandler)
//    func getResults(withPredicate: NSPredicate?, by context: NSManagedObjectContext) -> [BlazrResultDB]
    func deleteAllBlazrs(context: NSManagedObjectContext, completion: FinishedCompletionHandler)
}

class DatabaseStorage: IStorageManager {
    func saveResult(result: BlazrResult, with context: NSManagedObjectContext, completionHandler: FinishedCompletionHandler) {
//        context.performAndWait {
//            _ = BlazrResultDB.insert(into: context, blazrResult: result)
//        }
//        _ = context.saveOrRollback()
        completionHandler(true)
    }
    
//    func getResults(withPredicate: NSPredicate?, by context: NSManagedObjectContext) -> [BlazrResultDB] {
//        return BlazrResultDB.fetch(in: context, configurationBlock: { request in request.predicate = withPredicate})
//    }
    
    func deleteAllBlazrs(context: NSManagedObjectContext, completion: FinishedCompletionHandler) {
        // Specify a batch to delete with a fetch request
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: "BlazrResult")

        // Create a batch delete request for the
        // fetch request
        let deleteRequest = NSBatchDeleteRequest(
            fetchRequest: fetchRequest
        )

        // Specify the result of the NSBatchDeleteRequest
        // should be the NSManagedObject IDs for the
        // deleted objects
        deleteRequest.resultType = .resultTypeObjectIDs

        // Perform the batch delete
        let batchDelete = try? context.execute(deleteRequest) as? NSBatchDeleteResult

        guard let deleteResult = batchDelete?.result
            as? [NSManagedObjectID]
            else { return }

        let deletedObjects: [AnyHashable: Any] = [
            NSDeletedObjectsKey: deleteResult
        ]

        // Merge the delete changes into the managed
        // object context
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects,
            into: [context]
        )
    }
}

struct BlazrResult {
    let question: String
//    let diceResult: DiceResult
    let time: Date
    
    init(question: String) {
        time = Date()
        self.question = question
//        self.diceResult = diceResult
    }
    
//    init(fromDB: BlazrResultDB) {
//        self.time = fromDB.time
//        self.question = fromDB.question
//        self.diceResult = DiceResult(number: Int(exactly: fromDB.result)!)!
//    }
}
