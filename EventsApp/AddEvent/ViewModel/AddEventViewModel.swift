import Foundation

final class AddEventViewModel {

    var navigationTitle = AddEventConstants.navigationTitle

    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
        case titleImage
    }

    private(set) var cells: [AddEventViewModel.Cell] = []

    var onUpdate: () -> () = {}

    var assembly: AddEventAssembly?

    func viewDidDisappear() {
        assembly?.didFinishAddEvent()
    }

    func viewDidLoad() {
        cells = [
            .titleSubtitle(TitleSubtitleCellViewModel(title: AddEventConstants.titleSubtitleCellName, subTitle: "", placeholder: AddEventConstants.titleSubtitleCellNamePlaceHolder)),
            .titleSubtitle(TitleSubtitleCellViewModel(title: AddEventConstants.titleSubtitleCellDate, subTitle: "", placeholder: AddEventConstants.titleSubtitleCellDatePlaceHolder))
        ]

        onUpdate()
    }

    func numberOfRowsInSection() -> Int {
        return cells.count
    }

    func cellModelForRowAt(indexPath: IndexPath) -> Cell{
        return cells[indexPath.row]
    }

    deinit {
        print("Deinit from AddEventViewModel")
    }
}

extension AddEventViewModel {
    func doneButtonTapped () {

    }

    func cancelButtonTapped () {

    }
}
