//
// Created by Everis on 30/07/2020.
//

import Foundation

final class EventListViewModel {

    var title = EventListConstants.eventListTitle
    var assembly: EventListAssembly?

    func addNewEventTapped () {
        assembly?.startAddEvent()
    }
}
