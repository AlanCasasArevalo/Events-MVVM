import UIKit

class EventListViewController: UIViewController {

    var viewModel: EventListViewModel!

    @IBOutlet weak var eventListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
            self?.eventListTableView.reloadData()
        }

        viewModel.viewDidLoad()
        register()
        setDelegates()
        setupUI()
    }

    func setupUI() {
        self.view.backgroundColor = UIColor(named: ColorsConstants.mainColor)
        setupNavigation()
    }

    func getRightNavigationBar() -> UIBarButtonItem {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let right = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(rightButtonPressed))
        right.tintColor = UIColor(named: ColorsConstants.blueGreen)
        return right
    }

    func setupNavigation() {
        navigationItem.rightBarButtonItem = getRightNavigationBar()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func register() {
        eventListTableView.register(EventCell.self, forCellReuseIdentifier: EventListConstants.eventCell)
    }

    func setDelegates() {
        eventListTableView.delegate = self
        eventListTableView.dataSource = self
    }


}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cellModelForRowAt(indexPath: indexPath) {
        case .eventCell(let eventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: EventListConstants.eventCell, for: indexPath) as! EventCell
            cell.update(viewModel: eventCellViewModel)
            return cell
        }
    }
}

extension EventListViewController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
}

extension EventListViewController {
    @objc func rightButtonPressed() {
        viewModel.addNewEventTapped()
    }
}
