
import Foundation

final class AddEventViewModel {

    var assembly: AddEventAssembly?

    func addNewEventTapped () {
        assembly?.startAddEvent()
    }
}
