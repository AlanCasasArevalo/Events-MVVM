import Foundation

final class AddEventViewModel {

    var navigationTitle = AddEventConstants.navigationTitle

    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }

    private(set) var cells: [AddEventViewModel.Cell] = []

    var onUpdate: () -> () = {}

    var assembly: AddEventAssembly?

    func viewDidDisappear() {
        assembly?.didFinishAddEvent()
    }

    func viewDidLoad() {
        cells = [
            .titleSubtitle(TitleSubtitleCellViewModel(title: AddEventConstants.titleSubtitleCellName, subTitle: "", placeholder: AddEventConstants.titleSubtitleCellNamePlaceHolder, type: .text, onCellUpdate: {})),
            .titleSubtitle(TitleSubtitleCellViewModel(title: AddEventConstants.titleSubtitleCellDate, subTitle: "", placeholder: AddEventConstants.titleSubtitleCellDatePlaceHolder, type: .date, onCellUpdate: { [weak self] in
                self?.onUpdate()
            })),
            .titleSubtitle(TitleSubtitleCellViewModel(title: AddEventConstants.titleSubtitleCellBackground, subTitle: "", placeholder: AddEventConstants.titleSubtitleCellDatePlaceHolder, type: .image, onCellUpdate: { [weak self] in
                self?.onUpdate()
            }))
        ]

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

extension AddEventViewModel {
    func doneButtonTapped() {

    }

    func cancelButtonTapped() {

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
