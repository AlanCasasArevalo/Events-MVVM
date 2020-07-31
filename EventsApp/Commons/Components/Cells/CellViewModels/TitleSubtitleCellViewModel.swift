import Foundation

final class TitleSubtitleCellViewModel {

    enum CellType {
        case text
        case date
        case image
    }

    let title: String
    private(set) var subTitle: String
    let placeholder: String
    let type: CellType
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYY"
        return dateFormatter
    }()

    private(set) var onCellUpdate: () -> () = {}

    init(title: String, subTitle: String, placeholder: String, type: CellType, onCellUpdate: @escaping () -> ()) {
        self.title = title
        self.subTitle = subTitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }

    func updateModel(subtitle: String) {
        self.subTitle = subtitle
    }

    func updateDate(date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subTitle = dateString
        onCellUpdate()
    }

}