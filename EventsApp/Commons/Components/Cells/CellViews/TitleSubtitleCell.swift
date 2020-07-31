import UIKit


final class TitleSubtitleCell: UITableViewCell {
    let titleLabel = UILabel()
    private(set) var subTitleTextField = UITextField()
    var verticalStackView = UIStackView()

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
        titleLabel.text = viewModel.title
        subTitleTextField.text = viewModel.subTitle
        subTitleTextField.placeholder = viewModel.placeholder
    }

    func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subTitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
    }

    func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subTitleTextField)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}