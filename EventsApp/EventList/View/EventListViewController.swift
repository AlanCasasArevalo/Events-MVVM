
import UIKit

class EventListViewController: UIViewController {

    var viewModel: EventListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI () {
        self.view.backgroundColor = UIColor(named: ColorsConstants.mainColor)
        setupNavigation()
    }

    func getRightNavigationBar () -> UIBarButtonItem {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let right = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(rightButtonPressed))
        right.tintColor = UIColor(named: ColorsConstants.blueGreen)
        return right
    }

    func setupNavigation () {
        navigationItem.rightBarButtonItem = getRightNavigationBar()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension EventListViewController {
    @objc func rightButtonPressed () {
        viewModel.addNewEventTapped()
    }
}
