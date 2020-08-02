import Foundation

final class EventListViewModel {

    var title = EventListConstants.eventListTitle
    weak var assembly: EventListAssembly?

    private let coreDataManager: CoreDataManager
    private(set) var cells: [EventListViewModel.Cell] = []

    var onUpdate = {
    }

    enum Cell {
        case eventCell(EventCellViewModel)
    }

    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }

    func viewDidLoad() {
        reloadData()
    }

    func reloadData() {
        let events = coreDataManager.getAllElementsSaved()
        cells = events.map { event in
            var eventCellViewModel = EventCellViewModel(event: event)
            if let assembly = assembly {
                eventCellViewModel.onSelect = assembly.onSelect
            }
            return .eventCell(eventCellViewModel)
        }
        onUpdate()
    }


    func addNewEventTapped() {
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

extension EventListViewModel {
    func didSelectRowAt(indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .eventCell(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}