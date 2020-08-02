import UIKit
import CoreData

final class EventDetailViewModel {

    weak var assembly: EventDetailAssembly?
    private let coreDataManager: CoreDataManager
    private let eventId: NSManagedObjectID
    private(set) var event: Event?
    let date = Date()
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

    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let dateEvent = event?.date else { return nil }
        let timeRemainingParts = date.timeRemaining(endDate: dateEvent).components(separatedBy: ",")
        let timeRemainingViewModel = TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)
        return timeRemainingViewModel
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

