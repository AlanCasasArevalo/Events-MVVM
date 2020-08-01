
import UIKit

struct EventCellViewModel {

    let date = Date()

    var timeRemainingString: [String] {
        guard let endDate = event.date else { return [] }
        let dateArray = date.timeRemaining(endDate: endDate).components(separatedBy: ",") 
        return dateArray
    }

    var dateText: String {
        guard let dateEvent = event.date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: dateEvent)
    }

    var eventName: String {
        guard let nameOfEvent = event.name else { return "" }
        return nameOfEvent
    }

    var backgroundImage: UIImage {
        guard let backgroundImageData = event.image else { return UIImage() }
        guard let background = UIImage(data: backgroundImageData) else { return UIImage() }
        return background
    }

    private let event: Event

    init(event: Event) {
        self.event = event
    }

}
