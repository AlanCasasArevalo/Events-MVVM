import UIKit

final class EditEventViewModel {

    var navigationTitle = AddEventConstants.navigationAddTitle

    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }

    private(set) var cells: [EditEventViewModel.Cell] = []

    var onUpdate: () -> () = {}

    var assembly: EditEventAssembly?

    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    private let event: Event

    private var cellBuilder: EventCellBuilder
    private var eventService: EventServicesProtocol

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()

    init(cellBuilder: EventCellBuilder, eventService: EventServicesProtocol = EventServices(), event: Event) {
        self.cellBuilder = cellBuilder
        self.eventService = eventService
        self.event = event
    }

    func viewDidDisappear() {
        assembly?.didFinish()
    }

    func viewDidLoad() {
        initializeCellsArray()
        onUpdate()
    }

    func numberOfRowsInSection() -> Int {
        return cells.count
    }

    func cellModelForRowAt(indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }

    deinit {
        print("Deinit from EditEventViewModel")
    }
}

private extension EditEventViewModel {
    private func initializeCellsArray() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .text, onCellUpdate: nil)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .date, onCellUpdate: { [weak self] in
            self?.onUpdate()
        })
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .image, onCellUpdate: { [weak self] in
            self?.onUpdate()
        })

        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel else {
            return
        }

        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundImageCellViewModel)
        ]

        guard let name = event.name,
              let date = event.date,
              let imageData = event.image,
              let image = UIImage(data: imageData) else { return }
        nameCellViewModel.update(subtitle: name)
        dateCellViewModel.update(date: date)
        backgroundImageCellViewModel.update(image: image)

    }
}

extension EditEventViewModel {
    func doneButtonTapped() {
        guard let name = nameCellViewModel?.subTitle,
              let dateString = dateCellViewModel?.subTitle,
              let date = dateFormatter.date(from: dateString),
              let image = backgroundImageCellViewModel?.image else {
            return
        }
        eventService.performData(action: .update(event), inputData: .init(name: name, date: date, image: image))
        assembly?.didFinishUpdateEvent()
    }

    func cancelButtonTapped() {
        assembly?.didFinishUpdateEvent()
    }
}

extension EditEventViewModel {
    func updateText(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleModel):
            titleSubtitleModel.update(subtitle: subtitle)
        }
    }
}

extension EditEventViewModel {
    func didSelectRow(indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else {
                return
            }
            assembly?.showImagePicker { image in
                titleSubtitleCellViewModel.update(image: image)
            }
        }
    }
}
