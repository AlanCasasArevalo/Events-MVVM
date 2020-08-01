//
// Created by Everis on 01/08/2020.
//

import UIKit

final class EventCell: UITableViewCell {

    private let yearLabel = UILabel()
    private let mountLabel = UILabel()
    private let weekLabel = UILabel()
    private let dayLabel = UILabel()
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
        [yearLabel, mountLabel, weekLabel, dayLabel, dateLabel, eventNameLabel, backgroundImageView, verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [yearLabel, mountLabel, weekLabel, dayLabel].forEach {
            $0.font = .systemFont(ofSize: 28, weight: .medium)
            $0.textColor = .white
        }

        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        eventNameLabel.font = .systemFont(ofSize: 34, weight: .bold)
        eventNameLabel .textColor = .white

        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }

    private func setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)

        verticalStackView.addArrangedSubview(yearLabel)
        verticalStackView.addArrangedSubview(mountLabel)
        verticalStackView.addArrangedSubview(weekLabel)
        verticalStackView.addArrangedSubview(dayLabel)
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
        yearLabel.text = viewModel.yearText
        mountLabel.text = viewModel.mountText
        weekLabel.text = viewModel.weekText
        dayLabel.text = viewModel.dayText
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        backgroundImageView.image = viewModel.backgroundImage
    }
}