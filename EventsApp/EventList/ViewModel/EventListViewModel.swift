
import Foundation

final class EventListViewModel {

    var title = EventListConstants.eventListTitle
    var assembly: EventListAssembly?

    private let coreDataManager: CoreDataManager

    var onUpdate = {}

    enum Cell {
        case eventCell(EventCellViewModel)
    }

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func viewDidLoad () {
        cells = [
            .eventCell(EventCellViewModel()),
            .eventCell(EventCellViewModel()),
            .eventCell(EventCellViewModel())
        ]
        onUpdate()
    }

    private(set) var cells: [EventListViewModel.Cell] = []

    func addNewEventTapped () {
        assembly?.startAddEvent()
    }

    deinit {
        print("Deinit from EventListViewModel")
    }

}

extension EventListViewModel {
    func numberOfRowsInSection() -> Int {
        return cells.count
    }

    func cellModelForRowAt(indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
}