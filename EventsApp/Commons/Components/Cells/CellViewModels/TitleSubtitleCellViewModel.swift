import UIKit

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
    private(set) var image: UIImage?

    init(title: String, subTitle: String, placeholder: String, type: CellType, onCellUpdate: @escaping () -> ()) {
        self.title = title
        self.subTitle = subTitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }

    func update(subtitle: String) {
        self.subTitle = subtitle
    }

    func update(date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subTitle = dateString
        onCellUpdate()
    }

    func update(image: UIImage) {
        self.image = image
        onCellUpdate()
    }

}