import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!

    @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView! {
        didSet {
            timeRemainingStackView.setupUI()
        }
    }
    var viewModel: EventDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onUpdate = { [weak self] in
            guard let self = self, let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else { return }
            self.backgroundImage.image = self.viewModel.image
            self.timeRemainingStackView.update(viewModel: timeRemainingViewModel)
        }
        setupNavigation()
        viewModel.viewDidLoad()
    }

    func setupNavigation() {
        let editButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: viewModel, action: #selector(viewModel.editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    deinit {
        print("Deinit from EventDetailViewController")
    }
}
