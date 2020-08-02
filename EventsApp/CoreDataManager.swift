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

    func saveDataLocally(name: String, date: Date, image: UIImage) {
        let event = Event(context: manageObjectContext)

        let resizedImage = image.sameAspectRation(newHeight: 250)

        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(name, forKey: CoreDataConstants.saveDataLocallyName)
        event.setValue(date, forKey: CoreDataConstants.saveDataLocallyDate)
        event.setValue(imageData, forKey: CoreDataConstants.saveDataLocallyImageData)

        do {
            try manageObjectContext.save()
        } catch let error {
            print(error)
        }
    }

    func getAllElementsSaved() -> [Event] {
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: CoreDataConstants.entityName)
            let events = try manageObjectContext.fetch(fetchRequest)
            return events
        } catch let error {
            print(error)
            return [Event]()
        }
    }

    func getElementSavedById(elementId: NSManagedObjectID) -> Event? {
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: CoreDataConstants.entityName)
            let event = try manageObjectContext.existingObject(with: elementId) as? Event
            return event
        } catch let error {
            print(error)
            return nil
        }
    }
}
