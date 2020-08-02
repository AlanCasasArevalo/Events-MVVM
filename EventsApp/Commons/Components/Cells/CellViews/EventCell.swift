
import UIKit

final class EventCell: UITableViewCell {

    private let timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    private let dateLabel = UILabel()
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()

    private(set) var verticalStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    private func setupViews() {
        (timeRemainingLabels + [dateLabel, eventNameLabel, backgroundImageView, verticalStackView]).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        timeRemainingLabels.forEach {
            $0.font = .systemFont(ofSize: 28, weight: .medium)
            $0.textColor = .white
        }

        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        eventNameLabel.font = .systemFont(ofSize: 34, weight: .bold)
        eventNameLabel.textColor = .white

        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }

    private func setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)

        timeRemainingLabels.forEach {
            verticalStackView.addArrangedSubview($0)
        }

        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(dateLabel)
    }

    private func setupLayout() {
        backgroundImageView.pinToSuperView(edges: [.top, .left, .right])
        let backgroundImageBottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        backgroundImageBottomConstraint.priority = .required - 1
        backgroundImageBottomConstraint.isActive = true

        backgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pinToSuperView(edges: [.top, .bottom, .right], constant: 15)
        eventNameLabel.pinToSuperView(edges: [.left, .bottom], constant: 15)
    }

    func update(viewModel: EventCellViewModel) {
        timeRemainingLabels.forEach {
            $0.text = ""
        }
        viewModel.timeRemainingString.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        viewModel.loadImage { [weak self] image in
            self?.backgroundImageView.image = image
        }
    }
}