import UIKit


final class TitleSubtitleCell: UITableViewCell {

    let titleLabel = UILabel()
    var subTitleTextField = UITextField()
    var verticalStackView = UIStackView()
    private let padding: CGFloat = 15

    let datePickerView = UIDatePicker()
    let toolBar = UIToolbar(frame: .init(x: 0, y: 0, width: 20, height: 50))
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    }()

    private(set) var viewModel: TitleSubtitleCellViewModel?

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    func updateCell(viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subTitleTextField.text = viewModel.subTitle
        subTitleTextField.placeholder = viewModel.placeholder

        subTitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subTitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolBar
    }

    func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subTitleTextField.font = .systemFont(ofSize: 20, weight: .medium)

        [verticalStackView, titleLabel, subTitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        toolBar.setItems([doneButton], animated: false)
        datePickerView.datePickerMode = .date
    }

    func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subTitleTextField)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: padding),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }

    @objc private func doneButtonTapped () {
        self.viewModel?.updateDate(date: datePickerView.date)
    }
}