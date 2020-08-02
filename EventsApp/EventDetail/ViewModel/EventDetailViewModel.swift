import UIKit
import CoreData

final class EventDetailViewModel {

    weak var assembly: EventDetailAssembly?
    private let coreDataManager: CoreDataManager
    private let eventId: NSManagedObjectID
    private(set) var event: Event?
    var onUpdate = {}

    var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        let image = UIImage(data: imageData)
        return image
    }

    init(coreDataManager: CoreDataManager = .shared, eventId: NSManagedObjectID) {
        self.coreDataManager = coreDataManager
        self.eventId = eventId
    }

    func viewDidDisappear() {
        assembly?.didFinish()
    }

    func viewDidLoad() {
        event = coreDataManager.getElementSavedById(elementId: self.eventId)
        onUpdate()
    }

    deinit {
        print("Deinit from EventDetailViewModel")
    }
}

