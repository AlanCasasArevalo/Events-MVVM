import Foundation

final class AddEventViewModel {

    var navigationTitle = AddEventConstants.navigationTitle

    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }

    private(set) var cells: [AddEventViewModel.Cell] = []

    var onUpdate: () -> () = {}

    var assembly: AddEventAssembly?

    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?

    private var cellBuilder: EventCellBuilder
    private var coreDataManager: CoreDataManager

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()

    init( cellBuilder: EventCellBuilder, coreDataManager: CoreDataManager) {
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
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
        print("Deinit from AddEventViewModel")
    }
}

private extension AddEventViewModel {
    private func initializeCellsArray () {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .text, onCellUpdate: nil)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .date, onCellUpdate: { [weak self] in
            self?.onUpdate()
        })
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(type: .image, onCellUpdate:  { [weak self] in
            self?.onUpdate()
        })

        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel else { return }

        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundImageCellViewModel)
        ]
    }
}

extension AddEventViewModel {
    func doneButtonTapped() {
        guard let name = nameCellViewModel?.subTitle,
              let dateString = dateCellViewModel?.subTitle,
              let date = dateFormatter.date(from: dateString),
              let image = backgroundImageCellViewModel?.image  else { return }
        coreDataManager.saveDataLocally(name: name, date: date, image: image)
        assembly?.didFinishSaveEvent()
    }

    func cancelButtonTapped() {
        assembly?.didFinishSaveEvent()
    }
}

extension AddEventViewModel {
    func updateText(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleModel):
            titleSubtitleModel.update(subtitle: subtitle)
        }
    }
}

extension AddEventViewModel {
    func didSelectRow(indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else { return }
            assembly?.showImagePicker { image in
                titleSubtitleCellViewModel.update(image: image)
            }
        }
    }
}
