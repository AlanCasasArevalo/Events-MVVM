import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!

    var viewModel: EventDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onUpdate = { [weak self] in
            self?.backgroundImage.image = self?.viewModel.image
        }

        viewModel.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }

    deinit {
        print("Deinit from EventDetailViewController")
    }
}
