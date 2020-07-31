
import UIKit

class AddEventViewController: UIViewController {

    var viewModel: AddEventViewModel!
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
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
        print("Deinit from AddEventViewController")
    }
}

extension AddEventViewController {
    @objc func doneButtonTapped () {
        viewModel.doneButtonTapped()
    }

    @objc func cancelButtonTapped () {
        viewModel.cancelButtonTapped()
    }
}

extension AddEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellModelForRowAt(indexPath: indexPath)

        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleViewModel):
           let cell = tableView.dequeueReusableCell(withIdentifier: AddEventConstants.titleSubtitleCell, for: indexPath) as! TitleSubtitleCell
            cell.updateCell(viewModel: titleSubtitleViewModel)
            return cell
        case .titleImage:
            return UITableViewCell()

        }
    }

}
