import UIKit
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: ConstantsApp.nameApp)
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription)
        }
        return persistentContainer
    }()

    var manageObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func getAllElementsSaved<T: NSManagedObject> () -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            let results = try manageObjectContext.fetch(fetchRequest)
            return results
        } catch let error {
            print(error)
            return [T]()
        }
    }

    func getElementById <T: NSManagedObject> (elementId: NSManagedObjectID) -> T? {
        do {
            let result = try manageObjectContext.existingObject(with: elementId) as? T
            return result
        } catch let error {
            print(error)
            return nil
        }
    }

    func save() {
        do {
            try manageObjectContext.save()
        } catch let error {
            print(error)
        }
    }
}
