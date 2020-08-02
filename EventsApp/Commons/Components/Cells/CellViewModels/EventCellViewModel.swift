import UIKit
import CoreData

struct EventCellViewModel {

    let date = Date()
    private let event: Event

    init(event: Event) {
        self.event = event
    }

    private static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: EventListConstants.imageQueue, qos: .background)
    private var cacheImageKey: String {
        event.objectID.description
    }

    var onSelect: (NSManagedObjectID) -> () = { _ in }

    var timeRemainingString: [String] {
        guard let endDate = event.date else {
            return []
        }
        let dateArray = date.timeRemaining(endDate: endDate).components(separatedBy: ",")
        return dateArray
    }

    var dateText: String {
        guard let dateEvent = event.date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: dateEvent)
    }

    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let dateEvent = event.date else { return nil }
        let timeRemainingParts = date.timeRemaining(endDate: dateEvent).components(separatedBy: ",")
        let timeRemainingViewModel = TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
        return timeRemainingViewModel
    }

    var eventName: String {
        guard let nameOfEvent = event.name else {
            return ""
        }
        return nameOfEvent
    }

    func loadImage(completion: @escaping (UIImage?) -> ()) {
        if let image =  Self.imageCache.object(forKey: cacheImageKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let backgroundImageData = self.event.image,
                      let background = UIImage(data: backgroundImageData)
                        else {
                    completion(nil)
                    return
                }
                Self.imageCache.setObject(background, forKey: self.cacheImageKey as NSString)
                DispatchQueue.main.async {
                    completion(background)
                }
            }
        }
    }

    func didSelect () {
        onSelect(event.objectID)
    }

}
