
import UIKit

class EditEventViewController: UIViewController {

    var viewModel: EditEventViewModel!

    @IBOutlet weak var eventTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onUpdate = { [weak self] in
            self?.eventTableView.reloadData()
        }

        register()
        setDelegates()
        viewModel.viewDidLoad()
        setupUI()
    }

    func setupUI () {
        setupNavigation()
        setupTableView()
    }

    func setupNavigation() {
        navigationItem.title = viewModel.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationController?.navigationBar.tintColor = .black
    }

    func setupTableView () {
        // To force large titles
        eventTableView.contentInsetAdjustmentBehavior = .never
        eventTableView.setContentOffset(.init(x: 0, y: -1), animated: false)
        eventTableView.tableFooterView = UIView()
    }

    func register () {
        eventTableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: AddEventConstants.titleSubtitleCell)
    }

    func setDelegates () {
        eventTableView.delegate = self
        eventTableView.dataSource = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    deinit {
        print("Deinit from EditEventViewController")
    }
}

extension EditEventViewController {
    @objc func doneButtonTapped () {
        viewModel.doneButtonTapped()
    }
}

extension EditEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellModelForRowAt(indexPath: indexPath)

        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: AddEventConstants.titleSubtitleCell, for: indexPath) as! TitleSubtitleCell
            cell.updateCell(viewModel: titleSubtitleViewModel)
            cell.subTitleTextField.delegate = self
            return cell
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension EditEventViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string

        let point = textField.convert(textField.bounds.origin, to: eventTableView)
        if let indexPath = eventTableView.indexPathForRow(at: point) {
            viewModel.updateText(indexPath: indexPath, subtitle: text)
        }

        return true
    }
}
