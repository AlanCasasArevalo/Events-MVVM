
import Foundation

final class EventListViewModel {

    var title = EventListConstants.eventListTitle
    var assembly: EventListAssembly?

    func addNewEventTapped () {
        assembly?.startAddEvent()
    }
}
