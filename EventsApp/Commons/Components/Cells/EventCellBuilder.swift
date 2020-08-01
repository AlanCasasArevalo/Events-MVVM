
import Foundation

struct EventCellBuilder {
    func makeTitleSubtitleCellViewModel (type: TitleSubtitleCellViewModel.CellType, onCellUpdate: (() -> ())? = nil) -> TitleSubtitleCellViewModel {
        switch type {
        case .text: return TitleSubtitleCellViewModel(title: AddEventConstants.titleSubtitleCellName, subTitle: "", placeholder: AddEventConstants.titleSubtitleCellNamePlaceHolder, type: .text, onCellUpdate: onCellUpdate)
        case .date: return TitleSubtitleCellViewModel(title: AddEventConstants.titleSubtitleCellDate, subTitle: "", placeholder: AddEventConstants.titleSubtitleCellDatePlaceHolder, type: .date, onCellUpdate: onCellUpdate)
        case .image: return TitleSubtitleCellViewModel(title: AddEventConstants.titleSubtitleCellBackground, subTitle: "", placeholder: AddEventConstants.titleSubtitleCellDatePlaceHolder, type: .image, onCellUpdate: onCellUpdate)
        }
    }
}