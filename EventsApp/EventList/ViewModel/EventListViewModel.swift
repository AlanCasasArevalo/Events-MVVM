
import Foundation

final class EventListViewModel {

    var title = EventListConstants.eventListTitle
    weak var assembly: EventListAssembly?

    private let coreDataManager: CoreDataManager
    private(set) var cells: [EventListViewModel.Cell] = []

    var onUpdate = {}

    enum Cell {
        case eventCell(EventCellViewModel)
    }

    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }

    func viewDidLoad () {
        reloadData()
    }

    func reloadData () {
        let events = coreDataManager.getAllElementsSaved()
        cells = events.map { event in
            .eventCell(EventCellViewModel(event: event))
        }
        onUpdate()
    }


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